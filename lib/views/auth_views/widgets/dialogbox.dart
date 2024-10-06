import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/constants.dart';
import '../login_screen.dart';

class DialogBox {
  Future<void> authDialogBox() async {
    return Get.dialog(
      AlertDialog(
        title: const Text('Alert'),
        content: const Text(
            'Registration Successful. \nTap on \'CONTINUE\' to proceed.'),
        actions: <Widget>[
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(kPrimaryColor),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              textStyle: WidgetStateProperty.all(
                  const TextStyle(color: Colors.white)),
            ),
            child: const Text(
              'Continue',
            ),
            onPressed: () {
              Get.offAll(() => const LoginScreen());
            },
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
