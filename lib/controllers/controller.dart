import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  void sendNotification(BuildContext context) {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'welcome',
          title: 'Welcome to Duapa',
          body:
              'You are very welcome to Duapa App.\nThe app that sends u to the Farm.'),
    );
    // AwesomeNotifications().displayedStream;
    // AwesomeNotifications().listen((event) {
    //   // Get.to(new SplashScreen());
    //   Navigator.of(context)
    //       .pushReplacement(MaterialPageRoute(builder: (context) {
    //     return SplashScreen();
    //   }));
    // });
  }
}
