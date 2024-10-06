import 'package:duapa/controllers/checkout_controller.dart';
import 'package:duapa/controllers/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../services/constants.dart';

class PaymentMethodCard extends StatefulWidget {
  const PaymentMethodCard({super.key, required this.constraints});
  final BoxConstraints constraints;

  @override
  State<PaymentMethodCard> createState() => _PaymentMethodCardState();
}

class _PaymentMethodCardState extends State<PaymentMethodCard> {
  final CheckoutController checkoutController = Get.find();
  final PaymentController paymentController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.constraints.maxWidth,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: widget.constraints.maxWidth < 768 ? 15.0 : 20,
            color: Colors.grey.shade900.withOpacity(0.1),
            spreadRadius: 3.0,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: Obx(
        () => Row(
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
                    Row(
                      children: [
                        const Icon(Iconsax.card, size: 20),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Card Payment',
                              style: TextStyle(
                                color: Color(0xE8808080),
                                fontSize: 12,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/visa_card.svg',
                                  width: 40,
                                ),
                                SvgPicture.asset(
                                  'assets/svg/master_card.svg',
                                  width: 40,
                                ),
                                SvgPicture.asset(
                                  'assets/svg/american_express_card.svg',
                                  width: 40,
                                ),
                                SvgPicture.asset(
                                  'assets/svg/discover_card.svg',
                                  width: 40,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            paymentController.paymentMethod.value == 'Card'
                ? IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.toggle_on_circle5,
                      color: kPrimaryColor,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      paymentController.changePayment(value: 'Card');
                    },
                    icon: const Icon(
                      Iconsax.toggle_off_circle,
                      color: Color(0xE8808080),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodCardMomo extends StatefulWidget {
  const PaymentMethodCardMomo({super.key, required this.constraints});
  final BoxConstraints constraints;

  @override
  State<PaymentMethodCardMomo> createState() => _PaymentMethodCardMomoState();
}

class _PaymentMethodCardMomoState extends State<PaymentMethodCardMomo> {
  final CheckoutController checkoutController = Get.find();
  final PaymentController paymentController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.constraints.maxWidth,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: widget.constraints.maxWidth < 768 ? 15.0 : 20,
            color: Colors.grey.shade900.withOpacity(0.1),
            spreadRadius: 3.0,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: Obx(
        () => Row(
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
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/momo.svg',
                          width: 25,
                        ),
                        const SizedBox(width: 10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mobile Money',
                              style: TextStyle(
                                color: Color(0xE8808080),
                                fontSize: 12,
                              ),
                            ),
                            // Obx(
                            //   () => Text(
                            //     paymentController.phoneNumber.value == ''
                            //         ? 'Tap here to enter your phone number'
                            //         : '(${paymentController.networkProvider.value}) ${paymentController.phoneNumber.value}',
                            //     style: TextStyle(
                            //       color:
                            //           paymentController.phoneNumber.value == ''
                            //               ? kErrorColor
                            //               : const Color(0xE8808080),
                            //       fontStyle:
                            //           paymentController.phoneNumber.value == ''
                            //               ? FontStyle.italic
                            //               : FontStyle.normal,
                            //       fontSize: 12,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            paymentController.paymentMethod.value == 'Momo'
                ? IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.toggle_on_circle5,
                      color: kPrimaryColor,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      paymentController.changePayment(value: 'Momo');
                    },
                    icon: const Icon(
                      Iconsax.toggle_off_circle,
                      color: Color(0xE8808080),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
