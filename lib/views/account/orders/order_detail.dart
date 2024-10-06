import 'package:duapa/controllers/orders_controller.dart';
import 'package:duapa/controllers/payment_controller.dart';
import 'package:duapa/views/account/orders/invoice.dart';
import 'package:duapa/views/account/orders/track_order.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../services/constants.dart';
import '../../../services/theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/loading_widget.dart';
import 'widgets/order_address_card.dart';
import 'widgets/order_product_card.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen(
      {super.key, required this.orderid, required this.paymentStatus});
  final int orderid;
  final String paymentStatus;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final OrdersController ordersController = Get.find();
  final PaymentController paymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    ordersController.getUserOrders();
    return Scaffold(
      appBar: appBar(
        context: context,
        title: 'Order Detail',
        actions: [
          Visibility(
            visible: widget.paymentStatus != 'Pending',
            child: IconButton(
              onPressed: () {
                Get.to(() => PaymentInvoice(orderId: widget.orderid));
              },
              icon: const Icon(
                Iconsax.receipt,
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: SafeArea(
        bottom: true,
        child: FutureBuilder(
          future:
              ordersController.getUserOrderDetail(orderid: '${widget.orderid}'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AbyLoading();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  final order = snapshot.data!.data;
                  final currency = NumberFormat.simpleCurrency(
                    locale: 'en_US',
                    name: order.orderItems[0].convertedCurrencyCode,
                  );

                  return RefreshIndicator(
                    onRefresh: () {
                      return ordersController.getUserOrderDetail(
                          orderid: '${widget.orderid}');
                    },
                    child: LayoutBuilder(builder: (context, constraints) {
                      return ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          OrderAddressCard(
                            constraints: constraints,
                            orderShippingAddress: order.shippingAddress,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: constraints.maxWidth,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
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
                              itemCount: order.orderItems.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: OrderProductCard(
                                    constraints: constraints,
                                    product: order.orderItems[index],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          // summary of purchase
                          Container(
                            width: constraints.maxWidth,
                            // height: 150,
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
                                  'Summary',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Total Item Costs'),
                                    Text(
                                      currency.format(
                                          order.orderSummary.totalConverted),
                                      style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Total Shipping Costs'),
                                    Text(
                                      currency.format(
                                          order.orderSummary.totalShippingFee),
                                      style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Divider(),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Grand Total',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      currency.format(
                                          order.orderSummary.overallTotal),
                                      style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Text.rich(
                                  TextSpan(
                                    text: 'Payment status: ',
                                    children: [
                                      TextSpan(
                                        text: '${order.orderSummary.status}. ',
                                        style: TextStyle(
                                          color: order.orderSummary.status ==
                                                  'Paid'
                                              ? kPrimaryColor
                                              : kWarninngColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const TextSpan(
                                          text: 'Order awaiting payment!')
                                    ],
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          order.orderSummary.status == 'Pending'
                              ? PrimaryButton(
                                  text: 'Make Payment',
                                  onPressed: () async {
                                    await paymentController.payment(
                                      orderId: order.orderId.toString(),
                                      txRef: snapshot
                                          .data!.data.orderSummary.trxRef,
                                      amount: order.orderSummary.overallTotal
                                          .toStringAsFixed(2),
                                      currencyCode: order
                                          .orderSummary.convertedCurrencyCode,
                                    );
                                    setState(() {});
                                  },
                                )
                              : PrimaryButton(
                                  text: 'Track Order',
                                  onPressed: () {
                                    Get.to(() => TrackOrderScreen(
                                          orderId: order.orderId.toString(),
                                        ));
                                  },
                                ),
                        ],
                      );
                    }),
                  );
                } else {
                  return const Center(
                    child: Text('Empty'),
                  );
                }
              } else {
                return const Center(
                  child: Text('Error loading data'),
                );
              }
            } else {
              return const Center(
                child: Text('Error loading order, please try agian later!'),
              );
            }
          },
        ),
      ),
    );
  }
}
