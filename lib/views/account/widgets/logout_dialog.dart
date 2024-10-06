import 'package:duapa/services/auth_services.dart';
import 'package:duapa/services/constants.dart';
import 'package:flutter/material.dart';

enum ConfirmAction { cancel, accept }

class LogoutDialogBox {
  final AuthServices authServices = AuthServices();
  Future<ConfirmAction?> asyncConfirmDialog({
    required BuildContext context,
  }) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon/caution.png',
                scale: 5,
              ),
              const Text(
                'Are you sure?',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                'You want to logout of the system?',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(Colors.grey.shade200),
                foregroundColor:
                    WidgetStateProperty.all(Colors.grey.shade600),
                textStyle: WidgetStateProperty.all(
                    const TextStyle(color: Colors.white)),
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.cancel);
              },
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(kPrimaryColor),
                foregroundColor: WidgetStateProperty.all(Colors.white),
                textStyle: WidgetStateProperty.all(
                    const TextStyle(color: Colors.white)),
              ),
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.accept);
                authServices.logout();
              },
            )
          ],
        );
      },
    );
  }
}
