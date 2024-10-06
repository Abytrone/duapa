import 'package:duapa/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/shipping_address_controller.dart';

class DeleteDialog {
  final ShippingAddressController shippingAddressController = Get.find();
  asyncConfirmDialog({
    required BuildContext context,
    required String id,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/icon/caution.png',
              //   scale: 5,
              // ),
              Text(
                'Are you sure?',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.amber,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'You want to delete this address?',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xE8808080),
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
                Navigator.of(context).pop();
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
                Navigator.of(context).pop();
                shippingAddressController.deleteAddress(id: id);
              },
            )
          ],
        );
      },
    );
  }
}
