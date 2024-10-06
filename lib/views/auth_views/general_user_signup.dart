import 'package:duapa/services/auth_services.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/widgets/input_field.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../widgets/squre_logo.dart';

class GeneralSignup extends StatefulWidget {
  const GeneralSignup({super.key});

  @override
  State<GeneralSignup> createState() => _GeneralSignupState();
}

class _GeneralSignupState extends State<GeneralSignup> {
  TextEditingController userName = TextEditingController();
  TextEditingController fullName = TextEditingController();
  // TextEditingController lastName = TextEditingController();
  // String? sex;
  String? phone;
  String? isoCode;
  PhoneNumber number = PhoneNumber(isoCode: 'GH');
  TextEditingController password = TextEditingController();
  TextEditingController cpass = TextEditingController();
  // String countryValue = "";
  // String? stateValue = "";
  // String? cityValue = "";

  bool ssecured = true;
  bool psecured = true;
  final bool _isLoading = false;
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  final AuthServices authServices = AuthServices();

  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    // mediaQueryData.devicePixelRatio;
    mediaQueryData.size.height;
    mediaQueryData.size.width;

    return Scaffold(
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
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            alignment: AlignmentDirectional.topCenter,
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  /// padding logo
                  const SquareLogo(),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                    child: Text(
                      "General User",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: constraints.maxWidth < 768 ? 20 : 35,
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
                      'Please fill the form below to signup as a General User',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: constraints.maxWidth < 768 ? 12 : 20,
                        color: Theme.of(context).brightness ==
                                lightThemeData(context).brightness
                            ? kContentColorLightTheme
                            : kContentColorDarkTheme,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),

                    /// TextFromField Firstname
                    child: TextFromField(
                      validate: (firstName) {
                        if (firstName == null || firstName.isEmpty) {
                          return "* Required";
                        } else {
                          return null;
                        }
                      },
                      enabled: _isLoading ? false : true,
                      icon: Icons.person_outline,
                      label: "Full Name",
                      secured: false,
                      textCapitalization: TextCapitalization.words,
                      controller: fullName,
                      leftPadding: 20.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),

                    /// TextFromField Firstname
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
                      controller: userName,
                      leftPadding: 20.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Container(
                      height: 53,
                      width: constraints.maxWidth < 768 ? 450 : 500,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(blurRadius: 10.0, color: Colors.black12)
                        ],
                      ),
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 30.0,
                      ),
                      child: InternationalPhoneNumberInput(
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.DIALOG,
                        ),
                        formatInput: true,
                        initialValue: number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "* Required";
                          } else {
                            return null;
                          }
                        },
                        inputDecoration: const InputDecoration(
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black38,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        textStyle: const TextStyle(
                          color: kContentColorLightTheme,
                        ),
                        selectorTextStyle: const TextStyle(
                          color: kContentColorLightTheme,
                        ),
                        keyboardType: TextInputType.phone,
                        onInputChanged: (PhoneNumber value) {
                          phone = value.phoneNumber;
                          isoCode = value.isoCode;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),

                    /// TextFromField Password
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
                          icon: Icon(
                            psecured
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),

                    /// TextFromField Password
                    child: TextFromField(
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "* Required";
                        } else if (value != password.text) {
                          return "Confirm Password is not equal to Password";
                        } else {
                          return null;
                        }
                      },
                      enabled: _isLoading ? false : true,
                      icon: Icons.lock_outline_rounded,
                      sufIcon: IconButton(
                          icon: Icon(
                            ssecured
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
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
                      controller: cpass,
                      maxLines: 1,
                      leftPadding: 20.0,
                    ),
                  ),
                  SizedBox(height: constraints.maxWidth < 768 ? 30 : 15),

                  _isLoading
                      ? Padding(
                          padding: EdgeInsets.only(
                            left: constraints.maxWidth < 768 ? 160.0 : 450,
                            right: constraints.maxWidth < 768 ? 160.0 : 450,
                          ),
                          child: const LoadingIndicator(
                            indicatorType: Indicator.ballBeat,
                          ),
                        )
                      : PrimaryButton(
                          text: 'Signup',
                          onPressed: () {
                            if (formKey!.currentState!.validate()) {
                              final String body =
                                  'username=${userName.text}&fullname=${fullName.text}&phone_number=$phone&role=4&password=${password.text}&password_confirmation=${cpass.text}';
                              authServices.otpSend(
                                phoneNumber: phone!,
                                isoCode: isoCode!,
                                username: userName.text,
                                body: body,
                                userType: 'General_User',
                              );
                            }
                          },
                        ),
                  SizedBox(height: constraints.maxWidth < 768 ? 40 : 20),

                  /// Button Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Have an Account?",
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
                          Navigator.of(context).pushNamed('login');
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: kErrorColor,
                            fontSize: constraints.maxWidth < 768 ? 13 : 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
