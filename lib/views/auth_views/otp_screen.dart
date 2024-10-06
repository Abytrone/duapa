import 'package:duapa/services/auth_services.dart';
import 'package:duapa/services/password_reset_services.dart';
import 'package:duapa/views/auth_views/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

import '../../services/constants.dart';
import '../../services/theme.dart';
import '../widgets/primary_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    this.body,
    this.phoneNumber,
    this.isoCode,
    this.username,
    this.email,
    this.filepath,
    this.mapBody,
    this.userType,
    this.isResetPassword = false,
  });
  final String? body;
  final String? phoneNumber;
  final String? isoCode;
  final String? username;
  final String? email;
  final String? filepath;
  final Map<String, String>? mapBody;
  final String? userType;
  final bool isResetPassword;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with TickerProviderStateMixin {
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  final PasswordResetServices passwordResetServices = PasswordResetServices();
  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("This code will be expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 90, end: 0.0),
          duration: const Duration(seconds: 90),
          builder: (_, dynamic value, child) => Text(
            "${value.toInt()} s",
            style: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          onEnd: () {
            setState(() {});
          },
        ),
      ],
    );
  }

  final TextEditingController otpCode = TextEditingController();

  final AuthServices authServices = AuthServices();
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Lottie.asset(
                        'assets/json/105173-verification-code-otp.json',
                        controller: _controller,
                        height: 300,
                        repeat: true,
                        onLoaded: (composition) {
                          // Configure the AnimationController with the duration of the
                          // Lottie file and start the animation.
                          _controller
                            ..duration = composition.duration
                            ..repeat();
                        },
                      ),
                      Text(
                        'Verification code',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: constraints.maxWidth < 768 ? 17 : 25,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'A verification code has been sent to',
                        style: TextStyle(
                          fontSize: constraints.maxWidth < 768 ? 15 : 25,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.phoneNumber ?? widget.email!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: constraints.maxWidth < 768 ? 15 : 25,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              otpCode.clear();
                              if (widget.isResetPassword) {
                                passwordResetServices.otpSend(
                                  isoCode: widget.isoCode!,
                                  phone: widget.phoneNumber!,
                                  email: widget.phoneNumber == null
                                      ? widget.email!
                                      : '',
                                );
                              } else {
                                authServices.otpSend(
                                  phoneNumber: widget.phoneNumber!,
                                  isoCode: widget.isoCode!,
                                  username: widget.username!,
                                  userType: widget.userType!,
                                  body: widget.body,
                                  filepath: widget.filepath,
                                  email: widget.email,
                                );
                              }
                            },
                            child: Text(
                              ' Resend Code?',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: kPrimaryColor,
                                fontSize: constraints.maxWidth < 768 ? 15 : 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Pinput(
                          length: 4,
                          controller: otpCode,
                          // androidSmsAutofillMethod:
                          //     AndroidSmsAutofillMethod.smsUserConsentApi,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(4),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          focusedPinTheme: PinTheme(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(234, 239, 243, 1),
                              border: Border.all(
                                color: kPrimaryColor,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          onCompleted: (value) {
                            // print(value);
                            if (formKey!.currentState!.validate()) {
                              if (widget.userType == 'Extention Officer') {
                                widget.mapBody!
                                    .addAll({'otp_code': otpCode.text});
                                authServices.extensionOfficerSignup(
                                  body: widget.mapBody!,
                                  file: widget.filepath!,
                                );
                              } else if (widget.isResetPassword) {
                                Get.to(() => ResetPasswordScreen(
                                      email: widget.email,
                                      phone: widget.phoneNumber!,
                                      otp: otpCode.text,
                                    ));
                              } else {
                                final String body =
                                    '${widget.body}&otp_code=${otpCode.text}';
                                authServices.signup(
                                  body: body,
                                  userType: widget.userType!,
                                );
                              }
                            }
                          },
                        ),
                        const SizedBox(height: 40),
                        PrimaryButton(
                          text: 'Confirm',
                          onPressed: () {
                            if (formKey!.currentState!.validate()) {
                              if (widget.userType == 'Extention Officer') {
                                widget.mapBody!
                                    .addAll({'otp_code': otpCode.text});
                                authServices.extensionOfficerSignup(
                                  body: widget.mapBody!,
                                  file: widget.filepath!,
                                );
                              } else if (widget.isResetPassword) {
                                Get.to(() => ResetPasswordScreen(
                                      phone: widget.phoneNumber!,
                                      otp: otpCode.text,
                                    ));
                              } else {
                                final String body =
                                    '${widget.body}&otp_code=${otpCode.text}';
                                authServices.signup(
                                  body: body,
                                  userType: widget.userType!,
                                );
                              }
                            }
                          },
                        ),
                        buildTimer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
