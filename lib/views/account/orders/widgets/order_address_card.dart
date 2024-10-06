import 'package:duapa/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../models/order_detail_class.dart';
import '../../../../services/constants.dart';

class OrderAddressCard extends StatelessWidget {
  const OrderAddressCard({
    super.key,
    required this.constraints,
    required this.orderShippingAddress,
  });
  final BoxConstraints constraints;
  final ShippingAddress orderShippingAddress;

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();
    return Container(
      width: constraints.maxWidth,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: constraints.maxWidth < 768 ? 15.0 : 20,
            color: Colors.grey.shade900.withOpacity(0.1),
            spreadRadius: 3.0,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Iconsax.location,
                color: kPrimaryColor,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${userController.user.value.value!.user.firstName!} ${userController.user.value.value!.user.surname!}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userController.user.value.value!.user.phoneNumber!,
                    style: const TextStyle(
                      color: Color(0xE8808080),
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '${orderShippingAddress.address}, ${orderShippingAddress.city}',
                    style: const TextStyle(
                      color: Color(0xE8808080),
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '${orderShippingAddress.region}, ${orderShippingAddress.country}',
                    style: const TextStyle(
                      color: Color(0xE8808080),
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            ],
          ),
          const Icon(
            Iconsax.arrow_right_24,
            color: Color(0xE8808080),
          ),
        ],
      ),
    );
  }
}
