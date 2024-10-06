import 'package:duapa/controllers/checkout_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_controller.dart';
import '../../../models/checkout_product_model.dart';
import '../../../services/constants.dart';

class SummaryCard extends StatefulWidget {
  const SummaryCard({
    super.key,
    required this.constraints,
    required this.products,
  });
  final BoxConstraints constraints;
  final List<CheckoutProductModel> products;

  @override
  State<SummaryCard> createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  final CartController cartController = Get.find();
  final CheckoutController checkoutController = Get.find();

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.simpleCurrency(
        locale: 'en_US',
        name: cartController.products.value.value![0].convertedCurrencyCode);

    cartController.totalShipping.value = 0;
    for (var product in widget.products) {
      cartController.totalShipping.value +=
          (double.parse(product.price) * checkoutController.shipping.value) *
              cartController.quantity[product.productId]!;
    }

    return Container(
      width: widget.constraints.maxWidth,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: widget.constraints.maxWidth < 768 ? 10.0 : 20,
            color: Colors.grey.shade900.withOpacity(.1),
            spreadRadius: 3.0,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Summary',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Item Cost',
                style: TextStyle(fontSize: 12),
              ),
              Obx(() {
                return Text(
                  currency.format(cartController.total.value),
                  style: const TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Shipping Cost',
                style: TextStyle(fontSize: 12),
              ),
              Obx(() {
                return Text(
                  currency.format(cartController.totalShipping.value),
                  style: const TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
