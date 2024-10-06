import 'package:duapa/controllers/cart_controller.dart';
import 'package:duapa/controllers/checkout_controller.dart';
import 'package:duapa/controllers/shipping_address_controller.dart';
import 'package:duapa/views/cart/widgets/address_card.dart';
import 'package:duapa/views/cart/widgets/summary_card.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/checkout_product_model.dart';
import '../../services/constants.dart';
import '../../services/theme.dart';
import '../account/orders/orders.dart';
import '../widgets/app_bar.dart';
import 'widgets/checkout_product_card.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key, required this.products});
  final List<CheckoutProductModel> products;

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final ShippingAddressController shippingAddressController = Get.find();
  final CheckoutController checkoutController = Get.find();
  final CartController cartController = Get.find();

  @override
  void initState() {
    shippingAddressController.getDefaultAddress();
    grandTotal.value = cartController.grandTotal.value;
    super.initState();
  }

  String selectedValue = 'Sea'; // Default selected value

  RxDouble grandTotal = 00.0.obs;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.simpleCurrency(
        locale: 'en_US', name: widget.products[0].currencyCode);

    void handleRadioValueChanged(String? value) {
      setState(() {
        selectedValue = value!;
        grandTotal(0);

        if (selectedValue == 'Land') {
          checkoutController.shipping.value = 0.13;
          for (var product in widget.products) {
            grandTotal.value += (double.parse(product.price) *
                    cartController.quantity[product.productId]!) +
                ((0.13 * double.parse(product.price)) *
                    cartController.quantity[product.productId]!);
          }
        } else if (selectedValue == 'Air') {
          checkoutController.shipping.value = 0.20;
          for (var product in widget.products) {
            grandTotal.value += (double.parse(product.price) *
                    cartController.quantity[product.productId]!) +
                ((0.20 * double.parse(product.price)) *
                    cartController.quantity[product.productId]!);
          }
        } else {
          // Sea
          checkoutController.shipping.value = 0.10;

          for (var product in widget.products) {
            grandTotal.value += (double.parse(product.price) *
                    cartController.quantity[product.productId]!) +
                ((0.10 * double.parse(product.price)) *
                    cartController.quantity[product.productId]!);
          }
        }
      });
    }

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          checkoutController.shipping.value = 0.10;
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            appBar: appBar(context: context, title: 'Checkout'),
            backgroundColor: Theme.of(context).brightness ==
                    lightThemeData(context).brightness
                ? kContentColorDarkTheme
                : kContentColorLightTheme,
            body: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: constraints.maxWidth,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: shippingAddressController
                                        .defaultAddress.value.value ==
                                    null
                                ? AddressCard(
                                    constraints: constraints,
                                    hasDefault: 'false',
                                  )
                                : AddressCard(
                                    constraints: constraints,
                                    hasDefault: 'true',
                                    shippingAddressModel:
                                        shippingAddressController
                                            .defaultAddress.value.value,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // PaymentMethodCard(constraints: constraints),
                        // const SizedBox(height: 10),

                        // products to be purchased
                        Container(
                          width: constraints.maxWidth,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius:
                                    constraints.maxWidth < 768 ? 10.0 : 20,
                                color: Colors.grey.shade900.withOpacity(.1),
                                spreadRadius: 3.0,
                                offset: const Offset(5, 5),
                              ),
                            ],
                          ),
                          child: ListView.builder(
                            itemCount: widget.products.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: CheckoutProductCard(
                                  constraints: constraints,
                                  product: widget.products[index],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        //Dropdown for Delivery Mode
                        Container(
                          width: constraints.maxWidth,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius:
                                    constraints.maxWidth < 768 ? 10.0 : 20,
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
                                'Delivery Mode',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 20),
                              //   child: Container(
                              //     height: 55,
                              //     width: constraints.maxWidth < 768 ? null : 500,
                              //     padding: const EdgeInsets.only(left: 48),
                              //     decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius:
                              //           const BorderRadius.all(Radius.circular(14)),
                              //       boxShadow: [
                              //         BoxShadow(
                              //           color: Colors.grey.withOpacity(0.2),
                              //           spreadRadius: 3,
                              //           blurRadius: 5,
                              //           offset: const Offset(0, 2),
                              //         ),
                              //       ],
                              //     ),
                              //     child: Row(
                              //       children: [
                              //         Expanded(
                              //           child: DropdownButtonFormField(
                              //             items: <String>[
                              //               'Delivery by Sea',
                              //               'Delivery by Air'
                              //             ].map<DropdownMenuItem<String>>(
                              //                 (String value) {
                              //               return DropdownMenuItem<String>(
                              //                 value: value,
                              //                 child: Text(value),
                              //               );
                              //             }).toList(),
                              //             iconSize: 0,
                              //             decoration: const InputDecoration(
                              //               label: Text(
                              //                 'Select Delivery Mode',
                              //                 style: TextStyle(
                              //                   fontSize: 15,
                              //                   color: kContentColorLightTheme,
                              //                 ),
                              //               ),
                              //               border: InputBorder.none,
                              //             ),
                              //             onChanged: (value) {
                              //               setState(() {
                              //                 // print(data);
                              //                 // deliveryMode = value!;
                              //               });
                              //             },
                              //           ),
                              //         ),
                              //         Align(
                              //           alignment: Alignment.centerRight,
                              //           child: Padding(
                              //             padding: const EdgeInsets.only(right: 13),
                              //             child: Icon(
                              //               FontAwesomeIcons.angleDown,
                              //               color: Theme.of(context).brightness ==
                              //                       lightThemeData(context)
                              //                           .brightness
                              //                   ? kContentColorLightTheme
                              //                   : kContentColorDarkTheme,
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Radio(
                                    value: 'Land',
                                    groupValue: selectedValue,
                                    onChanged: handleRadioValueChanged,
                                  ),
                                  const Text('Land'),
                                  Radio(
                                    value: 'Sea',
                                    groupValue: selectedValue,
                                    onChanged: handleRadioValueChanged,
                                  ),
                                  const Text('Sea'),
                                  Radio(
                                    value: 'Air',
                                    groupValue: selectedValue,
                                    onChanged: handleRadioValueChanged,
                                  ),
                                  const Text('Air'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        // summary of purchase
                        SummaryCard(
                          constraints: constraints,
                          products: widget.products,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 25, horizontal: 10),
                          child: Text.rich(
                            TextSpan(
                              text:
                                  'Upon tapping \'Place Order\', I confirm I have read and acknowledged all',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 12,
                              ),
                              children: [
                                WidgetSpan(
                                  child: InkWell(
                                    onTap: () {},
                                    child: const Text(
                                      ' terms and conditions.',
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  width: constraints.maxWidth,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Grand Total',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Obx(() {
                              return Text(
                                currency.format(grandTotal.value),
                                style: const TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      PrimaryButton(
                        text: 'Place Order',
                        onPressed: () async {
                          List<Map<String, String>> products = [];

                          for (var i = 0; i < widget.products.length; i++) {
                            Map<String, String> product = {
                              'product_id': widget.products[i].productId,
                              'quantity': widget.products[i].quantity,
                              'product_price': widget.products[i].price,
                              //   'shipping_cost': '${(checkoutController.shipping.value *
                              //     double.parse(widget.products[i].price)) *
                              // cartController.quantity[widget.products[i].productId]!}'
                            };
                            products.add(product);
                          }
                          if (shippingAddressController
                                  .defaultAddress.value.value !=
                              null) {
                            final result = await checkoutController.addOrder(
                              shippingAddress: shippingAddressController
                                  .defaultAddress.value.value!.id
                                  .toString(),
                              products: products,
                              deliveryMode: selectedValue,
                            );
                            if (result) {
                              Get.to(() => const OrdersScreen(
                                  tabIndex: 1, isCheckout: true));
                            }
                          } else {
                            AbySnackBar.warningSnackbar(
                                text:
                                    'Please add a shipping address before placing an order.');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
