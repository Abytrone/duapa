import 'dart:async';
import 'package:duapa/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    startTime();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    // final box = GetStorage();
    // final boxToken = box.read('token');
    // check if token is there
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        _isLoggedIn = true;
      });
    }
    // else if (boxToken != null) {
    //   setState(() {
    //     token = boxToken.toString();
    //     _isLoggedIn = true;
    //   });
    //   AbySnackBar.successSnackbar(text: 'Box Token is not empty');
    // } else {
    //   // AbySnackBar.warningSnackbar(text: 'Token empty.');
    // }
  }

  // / Setting duration in splash screen
  startTime() async {
    return Timer(const Duration(seconds: 3), navigatorPage);
  }

  final UserController userController = Get.find();

  /// To navigate layout change
  void navigatorPage() async {
    final authData = await userController.getUser();
    // print('User: ${authData.user}');
    // print('Other: ${authData.other}');
    Get.offAllNamed(
      _isLoggedIn
          ? authData.user != null
              ? "bottomnavy"
              : authData.other != null
                  ? authData.other['message'] == 'Unauthenticated'
                      ? 'login'
                      : 'nointernet'
                  : "onboarding"
          : "onboarding",
    );
  }

  @override
  void didChangeDependencies() {
    precacheImage(Image.asset('assets/app_icon/icon.png').image, context);
    super.didChangeDependencies();
  }

  // Code Create UI Splash Screen
  @override
  Widget build(BuildContext context) {
    // print(_connectionStatus);
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Container(
              height: constraints.maxWidth < 768 ? 150 : 250,
              width: constraints.maxWidth < 768 ? 150 : 250,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(width: 1),
                image: const DecorationImage(
                  image: AssetImage('assets/app_icon/icon.png'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
