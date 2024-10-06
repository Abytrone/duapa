import 'package:duapa/views/account/orders/widgets/payment_method_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../controllers/payment_controller.dart';
import '../../../../services/constants.dart';

class OrderPaymentMethodCard extends StatelessWidget {
  const OrderPaymentMethodCard({super.key, required this.constraints});
  final BoxConstraints constraints;
  @override
  Widget build(BuildContext context) {
    final PaymentController paymentController = Get.find();
    return InkWell(
      onTap: () {
        paymentController.country.value == 'Ghana'
            ? Get.bottomSheet(
                Container(
                  width: constraints.maxWidth,
                  height: 300,
                  padding: const EdgeInsets.all(30),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      PaymentMethodCard(constraints: constraints),
                      const SizedBox(height: 20),
                      PaymentMethodCardMomo(constraints: constraints),
                    ],
                  ),
                ),
                isScrollControlled: false,
              )
            : null;
      },
      child: Container(
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
                  Iconsax.wallet,
                  color: kPrimaryColor,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment Method',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(
                      () => Text.rich(
                        TextSpan(
                          text: 'Payment method selected ',
                          children: [
                            TextSpan(
                              text: paymentController.paymentMethod.value,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                        style: const TextStyle(
                          color: Color(0xE8808080),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Icon(
              Iconsax.arrow_right_24,
              color: Color(0xE8808080),
            ),
          ],
        ),
      ),
    );
  }
}
