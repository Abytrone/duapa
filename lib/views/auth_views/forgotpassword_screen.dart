import 'package:duapa/services/constants.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../services/password_reset_services.dart';
import '../widgets/input_field.dart';
import '../widgets/squre_logo.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool isLoading = false;
  bool isPhone = true;
  String? phone;
  String? isoCode;
  final PhoneNumber number = PhoneNumber(isoCode: 'GH');
  final TextEditingController email = TextEditingController();
  final GlobalKey<FormState>? formKey2 = GlobalKey<FormState>();
  final PasswordResetServices passwordResetServices = PasswordResetServices();
  @override
  Widget build(BuildContext context) {
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Form(
              key: formKey2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /// padding logo
                  const SquareLogo(),
                  const SizedBox(height: 10),
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: constraints.maxWidth < 768 ? 20.0 : 35,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 10),
                    child: Text(
                      'Please provide your phone number or email below \nwe will send you a code to reset your password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: constraints.maxWidth < 768 ? 12.0 : 20,
                        color: Theme.of(context).brightness ==
                                lightThemeData(context).brightness
                            ? kContentColorLightTheme
                            : kContentColorDarkTheme,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  isPhone
                      ? Padding(
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
                                BoxShadow(
                                    blurRadius: 10.0, color: Colors.black12)
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
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                            enabled: isLoading ? false : true,
                            icon: Icons.email_outlined,
                            label: "Email",
                            secured: false,
                            textCapitalization: TextCapitalization.none,
                            controller: email,
                            inputType: TextInputType.emailAddress,
                            leftPadding: 20.0,
                          ),
                        ),

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isPhone = !isPhone;
                              email.clear();
                              phone = null;
                              isoCode = null;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text(
                              isPhone ? 'Use Email' : 'Use Phone',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  PrimaryButton(
                    text: 'Send',
                    onPressed: () {
                      if (formKey2!.currentState!.validate()) {
                        // print(phone == null ? email.text : '');
                        passwordResetServices.otpSend(
                          email: phone == null ? email.text : '',
                          phone: phone ?? '',
                          isoCode: isoCode ?? '',
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Or you can login from here.",
                        style: TextStyle(
                          fontSize: constraints.maxWidth < 768 ? 13.0 : 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness ==
                                  lightThemeData(context).brightness
                              ? kContentColorLightTheme
                              : kContentColorDarkTheme,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('login');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: kErrorColor,
                              fontWeight: FontWeight.bold,
                              fontSize: constraints.maxWidth < 768 ? 13.0 : 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
