import 'package:duapa/services/auth_services.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/widgets/input_field.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:duapa/views/widgets/squre_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool psecured = true;
  // bool _isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  final AuthServices authServices = AuthServices();

  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Obx(
            () => ListView(
              children: [
                Container(
                  alignment: AlignmentDirectional.topCenter,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        /// padding logo
                        const SquareLogo(),
                        const SizedBox(height: 40),
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: constraints.maxWidth < 768 ? 20.0 : 30,
                            color: Theme.of(context).brightness ==
                                    lightThemeData(context).brightness
                                ? kContentColorLightTheme
                                : kContentColorDarkTheme,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'signin to continue',
                          style: TextStyle(
                            fontSize: constraints.maxWidth < 768 ? 12 : 20,
                            color: Theme.of(context).brightness ==
                                    lightThemeData(context).brightness
                                ? kContentColorLightTheme
                                : kContentColorDarkTheme,
                          ),
                        ),

                        const SizedBox(height: 30),

                        /// TextFromField phone
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFromField(
                            validate: (username) {
                              if (username == null || username.isEmpty) {
                                return "* Required";
                              } else {
                                return null;
                              }
                            },
                            enabled:
                                authServices.isLoading.isTrue ? false : true,
                            icon: Icons.person_outline,
                            label: "Username / Email",
                            secured: false,
                            textCapitalization: TextCapitalization.none,
                            controller: username,
                            inputType: TextInputType.text,
                            leftPadding: 20.0,
                          ),
                        ),

                        /// TextFromField Password
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFromField(
                            icon: Icons.lock_outline_rounded,
                            enabled:
                                authServices.isLoading.isTrue ? false : true,
                            validate: (password) {
                              if (password == null || password.isEmpty) {
                                return "* Required";
                              } else {
                                return null;
                              }
                            },
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('forgotpassword');
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 15.0,
                                  bottom: 15.0,
                                  right: (constraints.maxWidth < 768)
                                      ? 30.0
                                      : 320.0,
                                ),
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(context).brightness ==
                                            lightThemeData(context).brightness
                                        ? kContentColorLightTheme
                                        : kContentColorDarkTheme,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        authServices.isLoading.isTrue
                            ? Padding(
                                padding: EdgeInsets.only(
                                  left:
                                      constraints.maxWidth < 768 ? 160.0 : 450,
                                  right: constraints.maxWidth < 768 ? 160 : 450,
                                ),
                                child: const LoadingIndicator(
                                  indicatorType: Indicator.ballBeat,
                                ),
                              )
                            : PrimaryButton(
                                text: 'Login',
                                onPressed: () {
                                  if (formKey!.currentState!.validate()) {
                                    // _login();
                                    authServices.login(
                                      username: username.text,
                                      password: password.text,
                                    );
                                  }
                                },
                              ),
                        const SizedBox(
                          height: 80,
                        ),

                        /// Button Login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: constraints.maxWidth < 768 ? 13 : 20,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).brightness ==
                                        lightThemeData(context).brightness
                                    ? kContentColorLightTheme
                                    : kContentColorDarkTheme,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('role');
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  color: kErrorColor,
                                  fontSize:
                                      constraints.maxWidth < 768 ? 13 : 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//   Future<void> _login() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final result = await InternetAddress.lookup(baseUrl);
//       if (result.isNotEmpty && result[0].address.isNotEmpty) {
//         final response = await http.post(
//           Uri.https(baseUrl, loginRoute, {
//             'username': username.text,
//             'password': password.text,
//           }),
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json'
//           },
//         );

//         if (response.statusCode == 200) {
//           if (response.body.toString() == 'Invalid Login Credentials') {
//             setState(() {
//               _isLoading = false;
//             });
//             await Flushbar(
//               message: response.body.toString(),
//               messageColor: kContentColorDarkTheme,
//               backgroundColor: kErrorColor,
//               duration: const Duration(seconds: 3),
//               flushbarStyle: FlushbarStyle.FLOATING,
//               borderRadius: const BorderRadius.all(Radius.circular(5)),
//               maxWidth: 350,
//               margin: const EdgeInsets.only(bottom: 30),
//             ).show(context);
//           } else if (response.body.toString() ==
//               'Sorry Your Account is Currently pending Please Contact Administrator') {
//             setState(() {
//               _isLoading = false;
//             });
//             await Flushbar(
//               message: response.body.toString(),
//               messageColor: kContentColorDarkTheme,
//               backgroundColor: kErrorColor,
//               duration: const Duration(seconds: 3),
//               flushbarStyle: FlushbarStyle.FLOATING,
//               borderRadius: const BorderRadius.all(Radius.circular(5)),
//               maxWidth: 350,
//               margin: const EdgeInsets.only(bottom: 30),
//             ).show(context);
//           } else {
//             final userData = userFromJson(response.body);
//             SharedPreferences localStorage =
//                 await SharedPreferences.getInstance();
//             localStorage.setString('token', userData.token);
//             localStorage.setString('data', response.body);
//             Navigator.of(context).pushReplacementNamed('bottomnavy');
//             setState(() {
//               _isLoading = false;
//             });
//             _controller.sendNotification(context);
//             await Flushbar(
//               message: 'Welcome ${userData.user.username}',
//               messageColor: kContentColorDarkTheme,
//               backgroundColor: kPrimaryColor,
//               duration: const Duration(seconds: 3),
//               flushbarStyle: FlushbarStyle.FLOATING,
//               borderRadius: const BorderRadius.all(Radius.circular(5)),
//               maxWidth: 350,
//               margin: const EdgeInsets.only(bottom: 30),
//             ).show(context);
//           }
//         } else {
//           // RESPONSE IF STATUS IS NOT 200
//           setState(() {
//             _isLoading = false;
//           });
//           await Flushbar(
//             message: 'Request failed with status: ${response.statusCode}.',
//             messageColor: kContentColorDarkTheme,
//             backgroundColor: kErrorColor,
//             duration: const Duration(seconds: 3),
//             flushbarStyle: FlushbarStyle.FLOATING,
//             borderRadius: const BorderRadius.all(Radius.circular(5)),
//             maxWidth: 350,
//             margin: const EdgeInsets.only(bottom: 30),
//           ).show(context);
//         }
//       } else {
//         setState(() {
//           _isLoading = false;
//         });
//         await Flushbar(
//           message: 'Please check your internet connection',
//           messageColor: kContentColorDarkTheme,
//           backgroundColor: kErrorColor,
//           duration: const Duration(seconds: 3),
//           flushbarStyle: FlushbarStyle.FLOATING,
//           borderRadius: const BorderRadius.all(Radius.circular(5)),
//           maxWidth: 350,
//           margin: const EdgeInsets.only(bottom: 30),
//         ).show(context);
//       }
//     } on SocketException catch (_) {
//       setState(() {
//         _isLoading = false;
//       });
//       await Flushbar(
//         message: 'Please check your internet connection',
//         messageColor: kContentColorDarkTheme,
//         backgroundColor: kErrorColor,
//         duration: const Duration(seconds: 3),
//         flushbarStyle: FlushbarStyle.FLOATING,
//         borderRadius: const BorderRadius.all(Radius.circular(5)),
//         maxWidth: 350,
//         margin: const EdgeInsets.only(bottom: 30),
//       ).show(context);
//     }
//   }
// }
