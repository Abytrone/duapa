import 'dart:convert' as convert;
import 'dart:io';

import 'package:duapa/controllers/controller.dart';
import 'package:duapa/controllers/user_controller.dart';
import 'package:duapa/models/user_class.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/server.dart';
import 'package:duapa/views/auth_views/company_logo.dart';
import 'package:duapa/views/auth_views/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../views/auth_views/login_screen.dart';
import '../views/auth_views/widgets/dialogbox.dart';
import '../views/widgets/loading_widget.dart';

class AuthServices {
  var isLoading = false.obs;
  final DialogBox dialogBox = DialogBox();
  final Controller _controller = Get.find<Controller>();

  Future<bool> login(
      {required String username, required String password}) async {
    try {
      isLoading(true);

      final result = await InternetAddress.lookup(baseUrl);
      if (result.isNotEmpty && result[0].address.isNotEmpty) {
        final response = await http.post(
          Uri.https(baseUrl, loginRoute, {
            'username': username,
            'password': password,
          }),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
        );

        // print(response.body);

        if (response.statusCode == 200) {
          if (response.body.toString() == 'Invalid Login Credentials') {
            isLoading(false);
            AbySnackBar.warningSnackbar(text: 'Invalid Login Credentials');
            return false;
          } else if (response.body.toString() ==
              'Please, Your account is currently pending approval.') {
            isLoading(false);
            AbySnackBar.warningSnackbar(
                text: 'Please, Your account is currently pending approval.');
            return false;
          } else {
            isLoading(false);

            final userData = userFromJson(response.body);

            final SharedPreferences localStorage =
                await SharedPreferences.getInstance();
            localStorage.setString('token', userData.token);

            // final box = GetStorage();
            // box.write('token', userData.token);

            final UserController userController = Get.find();
            final getUser = await userController.getUser();
            // print('Got USer: ${getUser.user}');
            if (getUser.user != null) {
              Get.offAllNamed('bottomnavy');
              _controller.sendNotification(Get.overlayContext!);

              AbySnackBar.successSnackbar(
                  text: 'Welcome ${userData.user.username}');
            } else {
              AbySnackBar.warningSnackbar(
                  text: 'Couldn\'t login, trying again.');
            }
            return true;
          }
        } else {
          isLoading(false);
          AbySnackBar.errorSnackbar(
              text: 'Request failed with status: ${response.statusCode}.');
          return false;
        }
      } else {
        isLoading(false);
        AbySnackBar.errorSnackbar(
            text: 'Please check your internet connection');
        return false;
      }
    } on SocketException catch (_) {
      isLoading(false);
      AbySnackBar.errorSnackbar(text: 'Please check your internet connection');
      return false;
    }
  }

  // FARMER SIGNUP
  Future<bool> signup({required String body, required String userType}) async {
    try {
      Get.dialog(
        const LoadingDialog(),
        barrierDismissible: false,
      );
      final response = await http.post(
        Uri.parse('https://$baseUrl$signupRoute?$body'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );
      var responseBody = convert.jsonDecode(response.body);
      // print(responseBody);
      // print(response.statusCode);
      if (response.statusCode == 201) {
        if (responseBody['error'] == false) {
          Navigator.of(Get.overlayContext!).pop();
          AbySnackBar.warningSnackbar(text: responseBody['message']);
        } else {
          Navigator.of(Get.overlayContext!).pop();
          AbySnackBar.successSnackbar(
              text: 'Welcome to Duapa ${responseBody['data']['username']}');
          if (userType == 'Service_Provider') {
            Get.offAll(
              () => CompanyLogo(
                companyId: responseBody['data']['id'],
                token: responseBody['token'],
              ),
            );
          } else {
            dialogBox.authDialogBox();
          }
        }
        return true;
      } else if (response.statusCode == 422) {
        // If signup request is successful but throws an error from db
        Navigator.of(Get.overlayContext!).pop();
        if (responseBody['status'] != null) {
          AbySnackBar.warningSnackbar(text: responseBody['message']);
        } else {
          // var res = signupErrorsFromJson(responseBody);
          // If the provided email already exist
          if (responseBody['errors']['email'] != null) {
            AbySnackBar.warningSnackbar(
                text: responseBody['errors']['email'][0]);

            // If the provided phone number already exist
          } else if (responseBody['errors']['phone_number'] != null) {
            AbySnackBar.warningSnackbar(
                text: responseBody['errors']['phone_number'][0]);
            // If the provided username already exist
          } else if (responseBody['errors']['username'] != null) {
            AbySnackBar.warningSnackbar(
                text: responseBody['errors']['username'][0]);
            // If the request is successful but not any of the above
          } else {
            AbySnackBar.warningSnackbar(text: responseBody['message']);
          }
        }
        return false;
      } else {
        Navigator.of(Get.overlayContext!).pop();
        // If server throws an error
        AbySnackBar.errorSnackbar(text: 'Error occured while processing data');
        return false;
      }
    } catch (e) {
      Navigator.of(Get.overlayContext!).pop();
      return false;
    }
  }

  //---------------------EXTENSION-OFFICER----------------------------
  Future<bool> extensionOfficerSignup(
      {required Map<String, String> body, required String file}) async {
    try {
      Get.dialog(
        const LoadingDialog(),
        barrierDismissible: false,
      );
      final Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json'
      };
      var request =
          http.MultipartRequest('POST', Uri.https(baseUrl, signupRoute))
            ..fields.addAll(body)
            ..headers.addAll(headers)
            ..files.add(await http.MultipartFile.fromPath('certificate', file));
      var response = await request.send();
      var res = await response.stream.bytesToString();
      final responseBody = convert.jsonDecode(res);

      // print(response.statusCode);
      // print(res);

      if (response.statusCode == 201) {
        if (responseBody['error'] == false) {
          Navigator.of(Get.overlayContext!).pop();
          AbySnackBar.warningSnackbar(text: responseBody['message']);
        } else {
          Navigator.of(Get.overlayContext!).pop();
          AbySnackBar.successSnackbar(
              text: 'Welcome to Duapa ${responseBody['data']['username']}');

          dialogBox.authDialogBox();
        }
        return true;
      } else if (response.statusCode == 422) {
        // If signup request is successful but throws an error from db
        Navigator.of(Get.overlayContext!).pop();
        if (responseBody['status'] != null) {
          AbySnackBar.warningSnackbar(text: responseBody['message']);
        } else {
          // var res = signupErrorsFromJson(responseBody);
          // If the provided email already exist
          if (responseBody['errors']['email'] != null) {
            AbySnackBar.warningSnackbar(
                text: responseBody['errors']['email'][0]);

            // If the provided phone number already exist
          } else if (responseBody['errors']['phone_number'] != null) {
            AbySnackBar.warningSnackbar(
                text: responseBody['errors']['phone_number'][0]);
            // If the provided username already exist
          } else if (responseBody['errors']['username'] != null) {
            AbySnackBar.warningSnackbar(
                text: responseBody['errors']['username'][0]);
            // If the request is successful but not any of the above
          } else {
            AbySnackBar.warningSnackbar(text: responseBody['message']);
          }
        }
        return false;
      } else {
        Navigator.of(Get.overlayContext!).pop();
        // If server throws an error
        AbySnackBar.errorSnackbar(text: 'Error occured while processing data');
        return false;
      }
    } catch (_) {
      Navigator.of(Get.overlayContext!).pop();
      AbySnackBar.errorSnackbar(text: 'Request failed');
      return false;
    }
  }
  //---------------------EXTENSION-OFFICER----------------------------

  // Send OTP REQUEST
  Future<bool> otpSend({
    required String phoneNumber,
    required String isoCode,
    String? email,
    required String username,
    String? body,
    Map<String, String>? mapBody,
    String? filepath,
    required String userType,
  }) async {
    Get.dialog(
      const LoadingDialog(),
      barrierDismissible: false,
    );
    Uri url = Uri.parse(
        'https://$baseUrl/api/v1/auth/user-otp-send?phone_number=$phoneNumber&email=$email&username=$username&country_code=$isoCode');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    var responseBody = convert.jsonDecode(response.body);
    // print(responseBody['status']);

    if (response.statusCode == 200) {
      if (responseBody['error'] == false) {
        Navigator.of(Get.overlayContext!).pop();
        AbySnackBar.warningSnackbar(text: responseBody['message']);
      } else {
        Navigator.of(Get.overlayContext!).pop();
        if (responseBody['status'] == 'pending') {
          Get.to(() => OtpScreen(
                body: body,
                email: email,
                userType: userType,
                phoneNumber: phoneNumber,
                isoCode: isoCode,
                username: username,
                filepath: filepath,
                mapBody: mapBody,
              ));
          return true;
        } else {
          AbySnackBar.warningSnackbar(text: responseBody['message']);
          return false;
        }
      }
      return true;
    } else if (response.statusCode == 422) {
      // If signup request is successful but throws an error from db
      Navigator.of(Get.overlayContext!).pop();
      if (responseBody['status'] != null) {
        AbySnackBar.warningSnackbar(text: responseBody['message']);
      } else {
        // var res = signupErrorsFromJson(responseBody);
        // If the provided email already exist
        if (responseBody['errors']['email'] != null) {
          AbySnackBar.warningSnackbar(text: responseBody['errors']['email'][0]);

          // If the provided phone number already exist
        } else if (responseBody['errors']['phone_number'] != null) {
          AbySnackBar.warningSnackbar(
              text: responseBody['errors']['phone_number'][0]);
          // If the provided username already exist
        } else if (responseBody['errors']['username'] != null) {
          AbySnackBar.warningSnackbar(
              text: responseBody['errors']['username'][0]);
          // If the request is successful but not any of the above
        } else {
          AbySnackBar.warningSnackbar(text: responseBody['message']);
        }
      }
      return false;
    } else {
      Navigator.of(Get.overlayContext!).pop();
      // If server throws an error
      AbySnackBar.errorSnackbar(text: 'Error occured while processing data');
      return false;
    }

    // if (response.statusCode == 200) {
    //   if (responseBody['status'] == 'pending') {
    //     Navigator.of(Get.overlayContext!).pop();
    //     Get.to(() => OtpScreen(
    //           body: body!,
    //           email: email,
    //           userType: userType,
    //           phoneNumber: phoneNumber,
    //           isoCode: isoCode,
    //           username: username,
    //           filepath: filepath,
    //         ));
    //     return true;
    //   } else {
    //     Navigator.of(Get.overlayContext!).pop();
    //     AbySnackBar.warningSnackbar(text: responseBody['message']);
    //     return false;
    //   }
    // } else {
    //   Navigator.of(Get.overlayContext!).pop();
    //   AbySnackBar.errorSnackbar(text: responseBody['message']);
    //   return false;
    // }
  }

  Future<bool> confirmPassword({required String password}) async {
    Get.dialog(
      const LoadingDialog(),
      barrierDismissible: false,
    );
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Uri url = Uri.parse(
        'https://$baseUrl/api/v1/auth/users/confirm-password?password=$password&password_confirmation=$password');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    // print(password);
    // print(response.body);
    var body = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (body['message'] == 'You have entered a wrong password') {
        Navigator.of(Get.overlayContext!).pop();
        AbySnackBar.errorSnackbar(text: body['message']);
        return false;
      } else if (body['message'] == 'success') {
        Navigator.of(Get.overlayContext!).pop();
        AbySnackBar.successSnackbar(text: 'Password confirmed');
        deleteAccount();
        return true;
      } else {
        Navigator.of(Get.overlayContext!).pop();
        AbySnackBar.errorSnackbar(text: 'Unkown error occured');
        return false;
      }
    } else {
      Navigator.of(Get.overlayContext!).pop();
      AbySnackBar.errorSnackbar(
          text: 'Request failed with status: ${response.statusCode}.');
      return false;
    }
  }

  Future<bool> deleteAccount() async {
    Get.dialog(
      const LoadingDialog(),
      barrierDismissible: false,
    );
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Uri url = Uri.parse('https://$baseUrl/api/v1/auth/users/delete-account');
    final response = await http.get(
      url,
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    // debugPrint(response.body);
    if (response.statusCode == 200) {
      Navigator.of(Get.overlayContext!).pop();
      AbySnackBar.successSnackbar(text: 'Account deleted successfully');
      logout();
      return true;
    } else {
      Navigator.of(Get.overlayContext!).pop();
      AbySnackBar.errorSnackbar(
          text: 'Request failed with status: ${response.statusCode}.');
      return false;
    }
  }

  Future<bool> companyLogo({
    required String companyId,
    required String filepath,
    required String token,
  }) async {
    Get.dialog(
      const LoadingDialog(),
      barrierDismissible: false,
    );
    Map<String, String> headers = {
      // 'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    Map<String, String> body = {'company_id': companyId};

    var request = http.MultipartRequest(
        'POST', Uri.https(baseUrl, '/api/v1/service-provider/update-logo'))
      ..headers.addAll(headers)
      ..fields.addAll(body)
      ..files.add(await http.MultipartFile.fromPath('company_logo', filepath));
    var response = await request.send();
    var res = await response.stream.bytesToString().then((value) => value);
    // var responseBody = convert.jsonDecode(res);
    debugPrint(res);
    // debugPrint(filepath);

    if (response.statusCode == 200) {
      Navigator.of(Get.overlayContext!).pop();
      AbySnackBar.successSnackbar(text: 'Company logo set successfully!');
      dialogBox.authDialogBox();
      return true;
    } else {
      Navigator.of(Get.overlayContext!).pop();
      AbySnackBar.warningSnackbar(
          text: 'Request failed with status: ${response.statusCode}.');
      return false;
    }
  }

  Future<AuthData> getAuthUser() async {
    try {
      // final box = GetStorage();
      final SharedPreferences localStorage =
          await SharedPreferences.getInstance();
      var token = localStorage.getString('token');

      // final result = await InternetAddress.lookup(baseUrl);
      // if (result.isNotEmpty && result[0].address.isNotEmpty) {
      Uri url = Uri.parse('https://$baseUrl/api/v1/users/auth-user');
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // print(token);
      // print('STSTUS CODE: ${response.statusCode}');
      // 16106568515
      // print(token);
      // print(response.body);
      if (response.statusCode == 200) {
        return AuthData(user: userFromJson(response.body), other: null);
      } else if (response.statusCode == 401) {
        // box.remove('token');
        localStorage.remove('token');
        final data = convert.jsonDecode(response.body);
        return AuthData(user: null, other: data);
      } else {
        return AuthData(other: null, user: null);
      }
    } catch (e) {
      return AuthData(other: null, user: null);
    }
  }

  Future<bool> logout() async {
    Get.dialog(
      const LoadingDialog(),
      barrierDismissible: false,
    );
    // final box = GetStorage();
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    final response = await http.post(
      Uri.https(baseUrl, logoutRoute),
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200) {
      // box.remove('token');
      localStorage.remove('token');
      Get.offAll(() => const LoginScreen());
      AbySnackBar.successSnackbar(
          text: 'You have been successfully logged out!');
      return true;
    } else if (response.statusCode == 401) {
      // box.remove('token');
      localStorage.remove('token');
      Get.offAll(() => const LoginScreen());
      AbySnackBar.successSnackbar(
          text: 'You have been successfully logged out!');
      return true;
    } else {
      Navigator.pop(Get.overlayContext!);
      AbySnackBar.errorSnackbar(
          text: 'Request failed with status: ${response.statusCode}.');
      return false;
    }
  }
}

class AuthData {
  User? user;
  dynamic other;

  AuthData({
    required this.other,
    required this.user,
  });
}
