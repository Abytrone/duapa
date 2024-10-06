import 'package:duapa/models/order_class.dart';
import 'package:duapa/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({
    super.key,
    required this.constraints,
    required this.order,
  });
  final BoxConstraints constraints;
  final Order order;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.simpleCurrency(
        locale: 'en_US', name: order.convertedCurrency);
    final date = DateFormat.yMMMEd();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        // width: constraints.maxWidth,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: constraints.maxWidth < 768 ? 15.0 : 20,
              color: Colors.grey.shade900.withOpacity(0.1),
              spreadRadius: 1.0,
              offset: const Offset(5, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#${order.orderCode}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${order.orderItemsCount} item(s) | ${date.format(order.createdAt)}',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      currency.format(order.convertedPrice),
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('|'),
                    ),
                    order.deliveryMode == null
                        ? const Text(
                            'Delivery unspecified',
                            style: TextStyle(
                              color: kDarkColor,
                              fontSize: 12,
                            ),
                          )
                        : Text(
                            'Delivery: ${order.deliveryMode}',
                            style: const TextStyle(
                              color: kDarkColor,
                              fontSize: 12,
                            ),
                          ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('|'),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: order.status == 'Paid'
                              ? kPrimaryColor
                              : kWarninngColor,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Text(
                        order.status == 'Paid' ? 'Paid' : 'Pending',
                        style: TextStyle(
                          color: order.status == 'Paid'
                              ? kPrimaryColor
                              : kWarninngColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kDarkLightColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}
