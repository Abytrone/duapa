import 'package:duapa/controllers/cart_controller.dart';
import 'package:duapa/controllers/product_controller.dart';
import 'package:duapa/models/checkout_product_model.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:duapa/views/widgets/empty.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../services/theme.dart';
import 'checkout.dart';
import 'widgets/cart_product_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = Get.find();
  final ProductsController productsController = Get.find();

  Future<void> refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Cart'),
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: FutureBuilder(
        future: cartController.getCartProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Padding(
                padding: EdgeInsets.only(
                  left: Get.size.width < 768 ? 160.0 : 450,
                  right: Get.size.width < 768 ? 160 : 450,
                ),
                child: const LoadingIndicator(
                  indicatorType: Indicator.ballBeat,
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.data == null) {
                return const EmptyWidget(text: 'Cart empty!');
              } else {
                final currency = NumberFormat.simpleCurrency(
                  locale: 'en_US',
                  name: snapshot.data![0].convertedCurrencyCode,
                );
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      bottom: 120,
                      top: MediaQuery.of(context).padding.top,
                      child: SizedBox(
                        // height: constraints.maxHeight, // 580,
                        width: Get.size.width - 4,
                        child: RefreshIndicator(
                          onRefresh: () {
                            return refresh();
                          },
                          child: Obx(
                            () => cartController.products.value.value == null
                                ? const EmptyWidget(text: 'Cart empty!')
                                : ListView.builder(
                                    itemCount: cartController
                                        .products.value.value!.length,
                                    itemBuilder: (context, index) {
                                      return Slidable(
                                        endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: (context) async {
                                                final response =
                                                    await cartController
                                                        .deleteCartProduct(
                                                  productId: cartController
                                                      .products
                                                      .value
                                                      .value![index]
                                                      .productId,
                                                  index: index,
                                                );

                                                if (response &&
                                                    cartController
                                                            .products
                                                            .value
                                                            .value!
                                                            .length ==
                                                        1) {
                                                  cartController
                                                      .getCartProducts();
                                                  setState(() {});
                                                }
                                              },
                                              backgroundColor: kErrorColor,
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete_forever,
                                              label: 'Remove',
                                            ),
                                          ],
                                        ),
                                        child: CartProductCard(
                                          cartProducts: cartController
                                              .products.value.value![index],
                                          index: cartController
                                              .products.value.value!.length,
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: Get.size.width - 10,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              width: 1,
                              color: kPrimaryColor.withOpacity(.3),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Total Amount: ',
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Obx(
                                        () => Text(
                                          currency.format(
                                              cartController.grandTotal.value),
                                          style: TextStyle(
                                            fontSize:
                                                Get.size.width < 768 ? 15 : 20,
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Taxes are calculated at checkout',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                              SecondaryButtonFilled(
                                color: kPrimaryColor,
                                text: 'Checkout',
                                onTap: () {
                                  // print(cartController.quantity);
                                  var checkoutProduct =
                                      <CheckoutProductModel>[];
                                  // ignore: invalid_use_of_protected_member
                                  cartController.quantity.value
                                      .forEach((id, quantity) {
                                    for (var product in cartController
                                        .products.value.value!) {
                                      if (id == product.productId) {
                                        checkoutProduct.addAll({
                                          CheckoutProductModel(
                                            productId: product.productId,
                                            picture: product.picture,
                                            name: product.productName,
                                            price: '${product.convertedPrice}',
                                            quantity: quantity.toString(),
                                            shippingCost: '0',
                                            currencyCode: snapshot
                                                .data![0].convertedCurrencyCode,
                                          ),
                                        });
                                      }
                                    }
                                  });
                                  Get.to(
                                    () => Checkout(
                                      products: checkoutProduct,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            } else {
              return const EmptyWidget(text: 'Empty cart!');
            }
          } else {
            return const EmptyWidget(text: 'Empty cart!');
          }
        },
      ),
    );
  }
}
