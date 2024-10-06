import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

const kPrimaryColor = Color(0xFF00BF6D);
const kSecondaryColor = Color(0xFFFE9901);
const kDarkColor = Color(0xFF383739);
const kGreyColor = Color(0xFF6F6F6F);
const kLightGreyColor = Color.fromRGBO(153, 153, 153, 1);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);

const kDarkLightColor = Color(0xFFC8C8C8);

const kDefaultPadding = 20.0;

class AbySnackDialog {
  static void successSnackDialog({required String text}) {
    Get.dialog(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kPrimaryColor,
        ),
        child: const Column(
          children: [
            Text(
              'data',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              'data',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: true,
    );
  }
}

class AbySnackBar {
  static void successSnackbar({required String text}) {
    Get.snackbar(
      'Success Message',
      text,
      colorText: Colors.white,
      maxWidth: 350,
      backgroundColor: kPrimaryColor,
      borderRadius: 5,
      margin: const EdgeInsets.only(bottom: 30),
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      duration: const Duration(seconds: 2),
      mainButton: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Icon(
          Iconsax.close_circle,
          color: Colors.white,
        ),
      ),
    );
  }

  static void errorSnackbar({required String text}) {
    Get.snackbar(
      'Error Message',
      text,
      colorText: Colors.white,
      maxWidth: 350,
      backgroundColor: kErrorColor,
      borderRadius: 5,
      margin: const EdgeInsets.only(bottom: 30),
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      duration: const Duration(seconds: 5),
      mainButton: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Icon(
          Iconsax.close_circle,
          color: Colors.white,
        ),
      ),
    );
  }

  static void warningSnackbar({required String text}) {
    Get.snackbar(
      'Warning Message',
      text,
      colorText: Colors.white,
      maxWidth: 350,
      backgroundColor: kWarninngColor,
      borderRadius: 5,
      margin: const EdgeInsets.only(bottom: 30),
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      duration: const Duration(seconds: 10),
      mainButton: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Icon(
          Iconsax.close_circle,
          color: Colors.white,
        ),
      ),
    );
  }
}
