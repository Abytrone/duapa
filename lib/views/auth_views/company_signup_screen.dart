import 'package:duapa/controllers/country_controller.dart';
import 'package:duapa/services/auth_services.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/widgets/input_field.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../widgets/squre_logo.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController companyName = TextEditingController();
  TextEditingController username = TextEditingController();
  String? phone;
  String? isoCode;
  final CountryController countryController = Get.find();
  TextEditingController email = TextEditingController();
  TextEditingController serviceRendered = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cpass = TextEditingController();
  bool ssecured = true;
  bool psecured = true;
  final bool _isLoading = false;
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  final AuthServices authServices = AuthServices();
  @override
  void dispose() {
    // formKey!.currentState!.dispose();
    super.dispose();
  }

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
                      "Service Provider",
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
                      'Please fill the form below to signup as a Service Provider',
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
                      label: "Company Name",
                      secured: false,
                      textCapitalization: TextCapitalization.words,
                      controller: companyName,
                      leftPadding: 20.0,
                    ),
                  ),
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
                      icon: Icons.person,
                      label: "User Name",
                      secured: false,
                      textCapitalization: TextCapitalization.none,
                      controller: username,
                      leftPadding: 20.0,
                    ),
                  ),
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
                      icon: Icons.design_services,
                      label: "Services Rendered",
                      secured: false,
                      textCapitalization: TextCapitalization.words,
                      controller: serviceRendered,
                      leftPadding: 20.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
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
                      padding: const EdgeInsets.only(left: 20.0, right: 30.0),
                      child: InternationalPhoneNumberInput(
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.DIALOG,
                        ),
                        formatInput: true,
                        initialValue: PhoneNumber(
                            isoCode: countryController
                                .country.value.value['countryCode']),
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
                    padding: const EdgeInsets.symmetric(vertical: 10.0),

                    /// TextFromField Email
                    child: TextFromField(
                      validate: (email) {
                        String pattern =
                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                            r"{0,253}[a-zA-Z0-9])?)*$";
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(email!)) {
                          return 'Enter a valid email address';
                        } else if (email.isEmpty) {
                          return "* Required";
                        } else {
                          return null;
                        }
                      },
                      enabled: _isLoading ? false : true,
                      icon: Icons.email_outlined,
                      label: "Email",
                      secured: false,
                      textCapitalization: TextCapitalization.none,
                      controller: email,
                      inputType: TextInputType.emailAddress,
                      leftPadding: 20.0,
                    ),
                  ),

                  /// TextFromField Password
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
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

                  /// TextFromField Password
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                          text: 'Next',
                          onPressed: () {
                            if (formKey!.currentState!.validate()) {
                              final String body =
                                  'username=${username.text}&company_name=${companyName.text}&phone_number=$phone&email=${email.text}&service_rendered=${serviceRendered.text}&role=5&password=${password.text}&password_confirmation=${cpass.text}';
                              authServices.otpSend(
                                phoneNumber: phone!,
                                isoCode: isoCode!,
                                username: username.text,
                                email: email.text,
                                body: body,
                                userType: 'Service_Provider',
                              );
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
