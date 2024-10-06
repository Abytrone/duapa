import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../models/order_detail_class.dart';
import '../../../../services/constants.dart';

class OrderProductCard extends StatefulWidget {
  const OrderProductCard({
    super.key,
    required this.constraints,
    required this.product,
  });
  final BoxConstraints constraints;
  final OrderItem product;

  @override
  State<OrderProductCard> createState() => _OrderProductCardState();
}

class _OrderProductCardState extends State<OrderProductCard> {
  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.simpleCurrency(
        locale: 'en_US', name: widget.product.convertedCurrencyCode);
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
                height: 100,
                width: 100,
                placeholderCacheHeight: 100,
                placeholderCacheWidth: 100,
                placeholder: 'assets/img/placeholder.png',
                image: widget.product.url,
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
                Row(
                  children: [
                    Text(
                      widget.product.title,
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: widget.constraints.maxWidth < 768 ? 14 : 24,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
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
                      currency.format(widget.product.convertedPrice),
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: widget.constraints.maxWidth < 768 ? 12 : 15,
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
                    Text(
                      currency.format(widget.product.shippingFee),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: widget.constraints.maxWidth < 768 ? 12 : 15,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Divider(height: 5),
                ),
                Row(
                  children: [
                    Text(
                      'Total: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade600,
                        fontSize: widget.constraints.maxWidth < 768 ? 15 : 20,
                      ),
                    ),
                    Text(
                      currency.format(widget.product.itemTotal),
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.constraints.maxWidth < 768 ? 15 : 20,
                      ),
                    ),
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
