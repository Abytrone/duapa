import 'package:duapa/controllers/product_controller.dart';
import 'package:duapa/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/cart_controller.dart';
import '../../../models/cart_class.dart';
import '../../home/product_screen.dart';

class CartProductCard extends StatefulWidget {
  const CartProductCard({
    super.key,
    // required this.constraints,
    required this.cartProducts,
    required this.index,
  });
  // final BoxConstraints constraints;
  final CartProduct cartProducts;
  final int index;

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  final CartController cartController = Get.find();
  final ProductsController productsController = Get.find();
  RxDouble subTotal = 0.00.obs;
  RxInt qty = 1.obs;
  RxDouble shipping = 0.00.obs;
  final double initShippingPercent = 0.10;
  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.simpleCurrency(
        locale: 'en_US', name: widget.cartProducts.convertedCurrencyCode);
    // ignore: invalid_use_of_protected_member
    qty.value = cartController.quantity.value[widget.cartProducts.productId]!;
    subTotal.value = widget.cartProducts.convertedPrice * qty.value;
    shipping.value =
        (initShippingPercent * widget.cartProducts.convertedPrice) * qty.value;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return ProductScreen(
                productId: widget.cartProducts.productId,
              );
            }),
          );
        },
        child: Container(
          // width: Get.size.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: Get.size.width < 768 ? 10.0 : 20,
                color: Colors.grey.shade900.withOpacity(.1),
                spreadRadius: 3.0,
                offset: const Offset(5, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: FadeInImage.assetNetwork(
                            height: 80,
                            width: 80,
                            placeholderCacheHeight: 80,
                            placeholderCacheWidth: 80,
                            placeholder: 'assets/img/placeholder.png',
                            image: widget.cartProducts.picture,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Get.size.width < 768 ? 200 : 400,
                              child: Text(
                                widget.cartProducts.productName,
                                maxLines: 2,
                                softWrap: true,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Get.size.width < 768 ? 14 : 24,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SizedBox(height: Get.size.width < 768 ? 5 : 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Shipping: ',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: Get.size.width < 768 ? 12 : 15,
                                  ),
                                ),
                                Obx(() {
                                  return Text(
                                    currency.format(shipping.value),
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: Get.size.width < 768 ? 12 : 15,
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
                  IconButton(
                    icon: const Icon(Icons.delete_forever),
                    onPressed: () async {
                      final response = await cartController.deleteCartProduct(
                        productId: widget.cartProducts.productId,
                        index: widget.index,
                      );

                      // print(cartController.products.value.value!.length);

                      if (response &&
                          cartController.products.value.value!.length == 1) {
                        await cartController.getCartProducts();
                        setState(() {});
                      }
                    },
                    color: kErrorColor,
                  ),
                ],
              ),
              // const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        // Reduce quantity button
                        Container(
                          height: 25,
                          width: 25,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          child: IconButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              if (qty > 1) {
                                qty--;
                                cartController.quantity.addAll(
                                  {
                                    widget.cartProducts.productId: qty.value,
                                  },
                                );
                                subTotal.value =
                                    widget.cartProducts.convertedPrice *
                                        qty.value;
                                shipping.value = (initShippingPercent *
                                        widget.cartProducts.convertedPrice) *
                                    qty.value;

                                cartController.grandTotal.value -=
                                    widget.cartProducts.convertedPrice +
                                        (initShippingPercent *
                                            widget.cartProducts.convertedPrice);
                              } else if (qty.value == 1) {
                                cartController.quantity.addAll(
                                  {
                                    widget.cartProducts.productId: qty.value,
                                  },
                                );
                                subTotal.value =
                                    widget.cartProducts.convertedPrice *
                                        qty.value;
                                shipping.value = (initShippingPercent *
                                        widget.cartProducts.convertedPrice) *
                                    qty.value;
                                // cartController.total.value -= subTotal.value;
                              } else {
                                qty += 0;
                                cartController.quantity.addAll(
                                  {
                                    widget.cartProducts.productId: qty.value,
                                  },
                                );
                                subTotal.value =
                                    widget.cartProducts.convertedPrice *
                                        qty.value;
                                shipping.value = (initShippingPercent *
                                        widget.cartProducts.convertedPrice) *
                                    qty.value;
                                // cartController.total.value -= subTotal.value;
                              }
                            },
                            iconSize: 20,
                            icon: Icon(
                              Icons.remove,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                        // Quantity
                        Obx(() => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                qty.value.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            )),

                        // Add quantity button
                        Container(
                          height: 25,
                          width: 25,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          child: IconButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              if (qty >= 1) {
                                qty++;
                                cartController.quantity.addAll(
                                  {
                                    widget.cartProducts.productId: qty.value,
                                  },
                                );
                                subTotal.value =
                                    widget.cartProducts.convertedPrice *
                                        qty.value;
                                shipping.value = (initShippingPercent *
                                        widget.cartProducts.convertedPrice) *
                                    qty.value;
                                cartController.grandTotal.value +=
                                    widget.cartProducts.convertedPrice +
                                        (initShippingPercent *
                                            widget.cartProducts.convertedPrice);
                              } else {
                                qty += 1;
                                cartController.quantity.addAll(
                                  {
                                    widget.cartProducts.productId: qty.value,
                                  },
                                );
                                subTotal.value =
                                    widget.cartProducts.convertedPrice *
                                        qty.value;
                                shipping.value = (initShippingPercent *
                                        widget.cartProducts.convertedPrice) *
                                    qty.value;
                                cartController.grandTotal.value +=
                                    widget.cartProducts.convertedPrice +
                                        (initShippingPercent *
                                            widget.cartProducts.convertedPrice);
                              }
                            },
                            iconSize: 20,
                            icon: Icon(
                              Icons.add,
                              color: Colors.green.shade300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(() {
                      return Text(
                        currency.format(subTotal.value),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: Get.size.width < 768 ? 15 : 20,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
