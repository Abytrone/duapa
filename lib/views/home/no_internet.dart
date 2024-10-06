import 'package:duapa/services/constants.dart';
import 'package:duapa/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svg/cry_illustration.svg",
                  width: 300,
                ),
                const SizedBox(height: 30),
                const SizedBox(
                  width: 300,
                  child: Text(
                    'ERROR ESTABLISHING CONNECTION!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Please check your internet connection and try again!',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    Get.offAll(() => const SplashScreen());
                  },
                  style: const ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    backgroundColor: WidgetStatePropertyAll(kWarninngColor),
                  ),
                  child: const Text('Try again'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
