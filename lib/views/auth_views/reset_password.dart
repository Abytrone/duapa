import 'package:duapa/services/constants.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../services/password_reset_services.dart';
import '../widgets/input_field.dart';
import '../widgets/squre_logo.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen(
      {super.key, this.phone, this.email, required this.otp});
  final String? phone;
  final String? email;
  final String otp;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormState>? formKey2 = GlobalKey<FormState>();
  final PasswordResetServices passwordResetServices = PasswordResetServices();
  bool ssecured = true;
  bool psecured = true;
  final bool _isLoading = false;
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
                    'Reset Password',
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
                      'Please enter your new password and confirm it to replace your old password',
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

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextFromField(
                      validate: (password) {
                        if (password == null || password.isEmpty) {
                          return "* Required";
                        } else if (password.length < 6) {
                          return "Password should be at least 6 characters";
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
                      label: "New Password",
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
                    child: TextFromField(
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "* Required";
                        } else if (value != password.text) {
                          return "Password does not match!";
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
                      label: "Confirm new password",
                      secured: ssecured,
                      textCapitalization: TextCapitalization.none,
                      inputType: TextInputType.text,
                      controller: confirmPassword,
                      maxLines: 1,
                      leftPadding: 20.0,
                    ),
                  ),

                  const SizedBox(height: 10),

                  PrimaryButton(
                    text: 'Send',
                    onPressed: () {
                      if (formKey2!.currentState!.validate()) {
                        passwordResetServices.requestPasswordReset(
                          phone: widget.phone!,
                          email: widget.email!,
                          password: password.text,
                          confirmPassword: confirmPassword.text,
                          otp: widget.otp,
                        );
                      }
                    },
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
