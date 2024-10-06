import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/products_model.dart';
import '../../../services/constants.dart';
import '../../home/product_screen.dart';

class FarmerProductCard extends StatelessWidget {
  const FarmerProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.simpleCurrency(
        locale: 'en_US', name: product.convertedCurrencyCode);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return ProductScreen(
              productId: product.id.toString(),
            );
          }),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.grey.shade100,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: FadeInImage.assetNetwork(
                  height: 100,
                  width: 100,
                  placeholderCacheHeight: 100,
                  placeholderCacheWidth: 100,
                  placeholder: 'assets/img/placeholder.png',
                  image: product.picture,
                  fit: BoxFit.cover,
                ),
              ),
              // const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 250,
                              child: Text(
                                product.name,
                                maxLines: 2,
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  currency.format(product.convertedPrice),
                                  style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                // const Text(
                                //   '|',
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.bold,
                                //     fontSize: 17,
                                //   ),
                                // ),
                                // Text(
                                //   product.inCart,
                                //   style: const TextStyle(
                                //     fontSize: 12,
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 210, height: 5),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: kSecondaryColor.withOpacity(0.2),
                            ),
                            child: const Text(
                              'Approved',
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyle(
                                color: kSecondaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
