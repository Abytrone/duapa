import 'package:duapa/services/auth_services.dart';
import 'package:duapa/views/account/settings/currency.dart';
import 'package:duapa/views/account/settings/language.dart';
import 'package:duapa/views/account/settings/widgets/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../services/constants.dart';
import '../../../services/theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/input_field.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final AuthServices authServices = AuthServices();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  bool psecured = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Settings'),
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: ListView(
        children: [
          SettingItem(
            onTap: () {
              Get.to(() => const CurrencyScreen());
            },
            icon: Iconsax.wallet,
            text: 'Currency',
            buttonColor: Colors.grey.shade300,
            textColor: Colors.grey.shade700,
          ),
          SettingItem(
            onTap: () {
              Get.to(() => const LanguageScreen());
            },
            icon: Iconsax.language_circle,
            text: 'Language',
            buttonColor: Colors.grey.shade300,
            textColor: Colors.grey.shade700,
          ),
          SettingItem(
            onTap: () {
              deleteDialogBox();
            },
            icon: Iconsax.user_remove,
            text: 'Delete Account',
            buttonColor: kErrorColor,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Future<void> deleteDialogBox() async {
    return Get.dialog(
      AlertDialog(
        title: const Text(
          'Warning!',
          style: TextStyle(
            color: kWarninngColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Are you sure that you want to delete your account?\nThis will immediately log you out of your account and you will not be able to log in again.',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
              DialogTextField(
                icon: Icons.lock_outline_rounded,
                enabled: true,
                validate: (password) {
                  if (password == null || password.isEmpty) {
                    return "* Required";
                  } else {
                    return null;
                  }
                },
                horizontalPadding: 0,
                // sufIcon: IconButton(
                //     icon: Icon(psecured
                //         ? Icons.visibility_off_outlined
                //         : Icons.visibility_outlined),
                //     color: Colors.grey,
                //     onPressed: () {
                //       // setState(() {
                //       psecured = !psecured;
                //       // });
                //     }),
                label: "Password",
                secured: psecured,
                textCapitalization: TextCapitalization.none,
                inputType: TextInputType.text,
                controller: password,
                maxLines: 1,
                leftPadding: 0.0,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.grey.shade200),
                      foregroundColor:
                          WidgetStateProperty.all(Colors.grey.shade600),
                      textStyle: WidgetStateProperty.all(
                          const TextStyle(color: Colors.white)),
                    ),
                    child: const Text(
                      'Cancel',
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(kPrimaryColor),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      textStyle: WidgetStateProperty.all(
                          const TextStyle(color: Colors.white)),
                    ),
                    child: const Text(
                      'Delete Account',
                    ),
                    onPressed: () {
                      if (formKey!.currentState!.validate()) {
                        authServices.confirmPassword(password: password.text);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
