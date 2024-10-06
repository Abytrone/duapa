import 'package:duapa/controllers/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/cart_controller.dart';
import '../../../models/checkout_product_model.dart';
import '../../../services/constants.dart';

class CheckoutProductCard extends StatefulWidget {
  const CheckoutProductCard({
    super.key,
    required this.constraints,
    required this.product,
  });
  final BoxConstraints constraints;
  final CheckoutProductModel product;

  @override
  State<CheckoutProductCard> createState() => _CheckoutProductCardState();
}

class _CheckoutProductCardState extends State<CheckoutProductCard> {
  final CartController cartController = Get.find();
  final CheckoutController checkoutController = Get.find();
  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.simpleCurrency(
        locale: 'en_US', name: widget.product.currencyCode);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: FadeInImage.assetNetwork(
                height: 80,
                width: 80,
                placeholderCacheHeight: 80,
                placeholderCacheWidth: 80,
                placeholder: 'assets/img/placeholder.png',
                image: widget.product.picture,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: widget.constraints.maxWidth < 768 ? 210 : 400,
                  child: Text(
                    widget.product.name,
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: widget.constraints.maxWidth < 768 ? 14 : 24,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${widget.product.quantity} x',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Text(
                      ' | ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                        fontSize: widget.constraints.maxWidth < 768 ? 12 : 15,
                      ),
                    ),
                    Text(
                      currency.format(double.parse(widget.product.price) *
                          int.parse(widget.product.quantity)),
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.constraints.maxWidth < 768 ? 15 : 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: widget.constraints.maxWidth < 768 ? 5 : 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Shipping: ',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: widget.constraints.maxWidth < 768 ? 12 : 15,
                      ),
                    ),
                    Obx(() {
                      return Text(
                        currency.format((checkoutController.shipping.value *
                                double.parse(widget.product.price)) *
                            cartController.quantity[widget.product.productId]!),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: widget.constraints.maxWidth < 768 ? 12 : 15,
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
