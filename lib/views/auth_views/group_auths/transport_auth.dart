import 'dart:async';
import 'dart:io';

import 'package:csc_picker/csc_picker.dart';
import 'package:duapa/models/user_class.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/server.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/widgets/bottom_navy.dart';
import 'package:duapa/views/widgets/input_field.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/squre_logo.dart';

class TransportAuth extends StatefulWidget {
  @override
  State<TransportAuth> createState() => _TransportAuthState();
  const TransportAuth({super.key, this.title});
  final String? title;
}

class _TransportAuthState extends State<TransportAuth> {
  // FORM CONTROLLERS
  final TextEditingController firstName = TextEditingController();
  final TextEditingController surname = TextEditingController();
  final TextEditingController username = TextEditingController();
  String? sex;
  final String role = '3';
  final PhoneNumber phoneNumber = PhoneNumber(isoCode: 'GH');
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  String? phone;
  String countryValue = "";
  String? stateValue = "";
  String? cityValue = "";

  bool ssecured = true;
  bool psecured = true;
  bool _isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();

  File? _insuranceFile;
  PlatformFile? _insurancePlatformFile;

  selectInsurance() async {
    try {
      final file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'png'],
      );
      if (file != null) {
        setState(() {
          _insuranceFile = File(file.files.single.path!);
          _insurancePlatformFile = file.files.first;
        });
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Error picking file, please try again');
    }
  }

  File? _roadworthyFile;
  PlatformFile? _roadworthyPlatformFile;

  selectRoadworthy() async {
    try {
      final file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'png'],
      );
      if (file != null) {
        setState(() {
          _roadworthyFile = File(file.files.single.path!);
          _roadworthyPlatformFile = file.files.first;
        });
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Error picking file, please try again');
    }
  }

  File? _lisenceFile;
  PlatformFile? _lisencePlatformFile;

  selectLisence() async {
    try {
      final file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'png'],
      );
      if (file != null) {
        setState(() {
          _lisenceFile = File(file.files.single.path!);
          _lisencePlatformFile = file.files.first;
        });
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Error picking file, please try again');
    }
  }

  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.size.height;
    mediaQueryData.size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).brightness == lightThemeData(context).brightness
                ? kContentColorDarkTheme
                : kContentColorLightTheme,
        iconTheme: IconThemeData(
          color:
              Theme.of(context).brightness == lightThemeData(context).brightness
                  ? kContentColorLightTheme
                  : kContentColorDarkTheme,
        ),
      ),
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                /// padding logo
                const SquareLogo(),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                  child: Text(
                    "Signup as a Transporter",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Please fill the form below to signup\nas a Transporter',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),

                /// TextFromField Firstname
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFromField(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Required";
                      } else {
                        return null;
                      }
                    },
                    enabled: _isLoading ? false : true,
                    icon: Icons.person_outline,
                    label: "First Name",
                    secured: false,
                    textCapitalization: TextCapitalization.words,
                    controller: firstName,
                    leftPadding: 20.0,
                  ),
                ),

                /// TextFromField Surname
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFromField(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Required";
                      } else {
                        return null;
                      }
                    },
                    enabled: _isLoading ? false : true,
                    icon: Icons.person_outline,
                    label: "Surname",
                    secured: false,
                    textCapitalization: TextCapitalization.words,
                    controller: surname,
                    leftPadding: 20.0,
                  ),
                ),

                /// TextFromField Surname
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFromField(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Required";
                      } else {
                        return null;
                      }
                    },
                    enabled: _isLoading ? false : true,
                    icon: Icons.person_outline,
                    label: "Username",
                    secured: false,
                    textCapitalization: TextCapitalization.words,
                    controller: username,
                    leftPadding: 20.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Container(
                    height: 53.0,
                    width: mediaQueryData.size.width > 600 ? 450 : null,
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(blurRadius: 10.0, color: Colors.black12)
                        ]),
                    padding: const EdgeInsets.only(left: 20.0, right: 30.0),
                    child: DropdownButtonFormField<String>(
                      value: sex,
                      icon: const Icon(
                        FontAwesomeIcons.angleDown,
                        color: Colors.black38,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "* Required";
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(
                        color: Theme.of(context).brightness ==
                                lightThemeData(context).brightness
                            ? kContentColorLightTheme
                            : kContentColorLightTheme,
                      ),
                      dropdownColor: kContentColorDarkTheme,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.male,
                          color: Colors.black38,
                        ),
                        border: InputBorder.none,
                        label: Text(
                          'Gender',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Theme.of(context).brightness ==
                                    lightThemeData(context).brightness
                                ? kContentColorLightTheme
                                : kContentColorLightTheme,
                          ),
                        ),
                      ),
                      iconSize: 24,
                      elevation: 0,
                      onChanged: (String? newValue) {
                        setState(() {
                          sex = newValue!;
                        });
                      },
                      items: <String>[
                        'Male',
                        'Female',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Container(
                    height: 53,
                    width: mediaQueryData.size.width > 600 ? 450 : null,
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(blurRadius: 10.0, color: Colors.black12)
                        ]),
                    padding: const EdgeInsets.only(left: 20.0, right: 30.0),
                    child: InternationalPhoneNumberInput(
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.DIALOG,
                        trailingSpace: false,
                      ),
                      formatInput: true,
                      initialValue: phoneNumber,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "* Required";
                        } else {
                          return null;
                        }
                      },
                      textStyle: const TextStyle(
                        color: kContentColorLightTheme,
                      ),
                      selectorTextStyle: const TextStyle(
                        color: kContentColorLightTheme,
                      ),
                      inputDecoration: const InputDecoration(
                        border: InputBorder.none,
                        labelStyle: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black38,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      onInputChanged: (PhoneNumber value) {
                        phone = value.phoneNumber;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),

                  // FORM LOCATION WIDGET
                  child: SizedBox(
                    width: mediaQueryData.size.width > 600 ? 500 : null,
                    child: Column(
                      children: [
                        CSCPicker(
                          // key: _cscPickerKey,
                          showStates: true,
                          showCities: true,
                          flagState: CountryFlag.ENABLE,

                          ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.0),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 10.0,
                                color: Colors.black12,
                              ),
                            ],
                          ),

                          ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                          disabledDropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.0),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 10.0,
                                color: Colors.black12,
                              ),
                            ],
                          ),

                          ///selected item style [OPTIONAL PARAMETER]
                          selectedItemStyle: const TextStyle(
                            color: kContentColorLightTheme,
                            fontSize: 12,
                          ),

                          ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                          dropdownHeadingStyle: TextStyle(
                            color: Theme.of(context).brightness ==
                                    lightThemeData(context).brightness
                                ? kContentColorLightTheme
                                : kContentColorDarkTheme,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),

                          ///DropdownDialog Item style [OPTIONAL PARAMETER]
                          dropdownItemStyle: TextStyle(
                            color: Theme.of(context).brightness ==
                                    lightThemeData(context).brightness
                                ? kContentColorLightTheme
                                : kContentColorDarkTheme,
                            fontSize: 12,
                          ),

                          ///Dialog box radius [OPTIONAL PARAMETER]
                          dropdownDialogRadius: 10.0,

                          ///Search bar radius [OPTIONAL PARAMETER]
                          searchBarRadius: 10.0,

                          ///triggers once country selected in dropdown
                          onCountryChanged: (value) {
                            setState(() {
                              ///store value in country variable
                              countryValue = value;
                            });
                          },

                          ///triggers once state selected in dropdown
                          onStateChanged: (value) {
                            setState(() {
                              ///store value in state variable
                              stateValue = value;
                            });
                          },

                          ///triggers once city selected in dropdown
                          onCityChanged: (value) {
                            setState(() {
                              ///store value in city variable
                              cityValue = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    selectInsurance();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Container(
                      height: 53,
                      width: mediaQueryData.size.width > 600 ? 450 : null,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(blurRadius: 10.0, color: Colors.black12)
                          ]),
                      padding: const EdgeInsets.only(left: 30.0, right: 20.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_box_outlined,
                            color: Colors.black38,
                          ),
                          const SizedBox(width: 15),
                          const Text(
                            'Insurance:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: kContentColorLightTheme,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            _insurancePlatformFile == null
                                ? 'Select file'
                                : _insurancePlatformFile!.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              color: kContentColorLightTheme,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    selectRoadworthy();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Container(
                      height: 53,
                      width: mediaQueryData.size.width > 600 ? 450 : null,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(blurRadius: 10.0, color: Colors.black12)
                          ]),
                      padding: const EdgeInsets.only(left: 30.0, right: 20.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add_road_outlined,
                            color: Colors.black38,
                          ),
                          const SizedBox(width: 15),
                          const Text(
                            'Road Worthy:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: kContentColorLightTheme,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            _roadworthyPlatformFile == null
                                ? 'Select file'
                                : _roadworthyPlatformFile!.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              color: kContentColorLightTheme,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    selectLisence();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Container(
                      height: 53,
                      width: mediaQueryData.size.width > 600 ? 450 : null,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(blurRadius: 10.0, color: Colors.black12)
                          ]),
                      padding: const EdgeInsets.only(left: 30.0, right: 20.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.drive_eta,
                            color: Colors.black38,
                          ),
                          const SizedBox(width: 15),
                          const Text(
                            'Drivers Lisence:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: kContentColorLightTheme,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            _lisencePlatformFile == null
                                ? 'Select file'
                                : _lisencePlatformFile!.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              color: kContentColorLightTheme,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// TextFromField Password
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFromField(
                    validate: (password) {
                      if (password == null || password.isEmpty) {
                        return "* Required";
                      } else if (password.length < 6) {
                        return "Password should be at least 6 characters";
                      } else if (password.length > 15) {
                        return "Password should not be greater than 15 characters";
                      } else {
                        return null;
                      }
                    },
                    enabled: _isLoading ? false : true,
                    icon: Icons.lock_outline_rounded,
                    sufIcon: IconButton(
                        icon: Icon(psecured
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        color: Colors.grey,
                        onPressed: () {
                          setState(() {
                            psecured = !psecured;
                          });
                        }),
                    label: "Password",
                    secured: psecured,
                    textCapitalization: TextCapitalization.none,
                    inputType: TextInputType.text,
                    controller: password,
                    maxLines: 1,
                    leftPadding: 20.0,
                  ),
                ),

                /// TextFromField Password
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFromField(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Required";
                      } else if (value != password.text) {
                        return "Please this should match with your password";
                      } else {
                        return null;
                      }
                    },
                    enabled: _isLoading ? false : true,
                    icon: Icons.lock_outline_rounded,
                    sufIcon: IconButton(
                        icon: Icon(ssecured
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        color: Colors.grey,
                        onPressed: () {
                          setState(() {
                            ssecured = !ssecured;
                          });
                        }),
                    label: "Confirm Password",
                    secured: ssecured,
                    textCapitalization: TextCapitalization.none,
                    inputType: TextInputType.text,
                    controller: confirmpassword,
                    maxLines: 1,
                    leftPadding: 20.0,
                  ),
                ),

                const SizedBox(height: 30),

                _isLoading
                    ? const Padding(
                        padding: EdgeInsets.only(
                          left: 160.0,
                          right: 160,
                        ),
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballBeat,
                        ),
                      )
                    : PrimaryButton(
                        text: 'Signup',
                        onPressed: () {
                          if (formKey!.currentState!.validate()) {
                            signup();
                          }
                        },
                      ),
                const SizedBox(height: 40),

                /// Button Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Have an Account?",
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).brightness ==
                                lightThemeData(context).brightness
                            ? kContentColorLightTheme
                            : kContentColorDarkTheme,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('login');
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: kErrorColor,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //SIGNUP CONTROLLER------------------------------------------------------------
  Future<void> signup() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Map<String, String> body = {
        'first_name': firstName.text,
        'surname': surname.text,
        'username': username.text,
        'sex': sex!,
        'role': role,
        'phone_number': phone!,
        'country': countryValue,
        'region': stateValue!,
        'city': cityValue!,
        'password': password.text,
        'password_confirmation': confirmpassword.text,
      };
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json'
      };
      var request =
          http.MultipartRequest('POST', Uri.https(baseUrl, signupRoute))
            ..fields.addAll(body)
            ..headers.addAll(headers)
            ..files.add(await http.MultipartFile.fromPath(
              'road_worthy',
              _roadworthyFile!.path,
            ))
            ..files.add(await http.MultipartFile.fromPath(
              'driver_license',
              _lisenceFile!.path,
            ))
            ..files.add(await http.MultipartFile.fromPath(
              'insurance',
              _insuranceFile!.path,
            ));
      var response = await request.send();
      var res = await response.stream.bytesToString();
      // print(res);
      if (response.statusCode == 201) {
        final responseBody = userFromJson(res);
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', responseBody.token);

        Get.dialog(
          AlertDialog(
            title: const Text('Alert'),
            content: const Text(
                'Registration Successful. \nTap on \'CONTINUE\' to proceed.'),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'CONTINUE',
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const BottomNavy(),
                    ),
                  );
                  // Navigator.of(context).pop(ProceedAction.ACCEPT);
                },
              )
            ],
          ),
          barrierDismissible: false,
        );

        setState(() {
          _isLoading = false;
        });
        // print(responseBody);
        AbySnackBar.successSnackbar(
            text: 'Welcome to Duapa ${responseBody.user.username}');
      } else if (response.statusCode == 422) {
        setState(() {
          _isLoading = false;
        });
        AbySnackBar.warningSnackbar(
            text: 'Username or Phone Number already exist.');
      } else {
        setState(() {
          _isLoading = false;
        });
        AbySnackBar.errorSnackbar(
            text: 'Request failed with status: ${response.statusCode}.');
      }
    } on SocketException catch (_) {
      setState(() {
        _isLoading = false;
      });
      AbySnackBar.errorSnackbar(text: 'Request failed');
    }
  }
  //LOGIN CONTROLLER------------------------------------------------------------
}
