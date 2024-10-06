import 'package:duapa/services/auth_services.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/widgets/input_field.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../controllers/country_controller.dart';
import '../widgets/squre_logo.dart';

class FarmerSignup extends StatefulWidget {
  @override
  State<FarmerSignup> createState() => _FarmerSignupState();
  const FarmerSignup({super.key, this.title});
  final String? title;
}

class _FarmerSignupState extends State<FarmerSignup> {
  // FORM CONTROLLERS
  final CountryController countryController = Get.find();
  final TextEditingController fullName = TextEditingController();
  // final TextEditingController surname = TextEditingController();
  final TextEditingController username = TextEditingController();
  // String? sex;
  final PhoneNumber phoneNumber = PhoneNumber(isoCode: 'GH');
  // final TextEditingController services = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  String? phone;
  String? isoCode;
  // String countryValue = "";
  // String? stateValue = "";
  // String? cityValue = "";

  bool ssecured = true;
  bool psecured = true;
  final bool _isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  final AuthServices authServices = AuthServices();

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
        child: LayoutBuilder(builder: (context, constraints) {
          return Form(
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
                    "Signup as a Farmer",
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
                    'Please fill the form below to signup as a Farmer',
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
                    label: "Full Name",
                    secured: false,
                    textCapitalization: TextCapitalization.words,
                    controller: fullName,
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
                    height: 53,
                    width: constraints.maxWidth < 768 ? 450 : 500,
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
                        isoCode = value.isoCode;
                      },
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
                        text: 'Sign up',
                        onPressed: () {
                          if (formKey!.currentState!.validate()) {
                            final String body =
                                'username=${username.text}&fullname=${fullName.text}&phone_number=$phone&role=1&password=${password.text}&password_confirmation=${confirmpassword.text}';
                            authServices.otpSend(
                              phoneNumber: phone!,
                              isoCode: isoCode!,
                              username: username.text,
                              body: body,
                              userType: 'Farmer',
                            );
                          }
                        },
                      ),
                SizedBox(height: constraints.maxWidth < 768 ? 40 : 20),
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
                        "Login",
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
          );
        }),
      ),
    );
  }
}
