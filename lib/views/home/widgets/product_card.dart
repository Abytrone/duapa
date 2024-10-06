import 'package:duapa/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../controllers/product_controller.dart';
import '../../../models/products_model.dart';
import '../../../services/constants.dart';
import '../product_screen.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.products,
    required this.constraints,
    required this.isDetailScreen,
  });
  final Product products;
  final BoxConstraints constraints;
  final bool isDetailScreen;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final CartController cartController = Get.find();
  final ProductsController productsController = Get.find();
  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.simpleCurrency(
        locale: 'en_US', name: widget.products.convertedCurrencyCode);
    return Container(
      margin: EdgeInsets.only(right: widget.isDetailScreen ? 10 : 0),
      padding: EdgeInsets.all(widget.constraints.maxWidth < 768 ? 8 : 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(widget.constraints.maxWidth < 768 ? 8 : 16),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: widget.constraints.maxWidth < 768 ? 10.0 : 20,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return ProductScreen(
                        productId: widget.products.id,
                      );
                    }),
                  );
                },
                child: Stack(
                  children: [
                    SizedBox(
                      height: widget.constraints.maxWidth < 768 ? 170 : 270,
                      width: widget.constraints.maxWidth < 768
                          ? widget.isDetailScreen
                              ? 175
                              : 250
                          : 350,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/img/placeholder.png',
                          image: widget.products.picture,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      child: widget.products.inCart == '1'
                          ? IconButton(
                              onPressed: () {
                                AbySnackBar.warningSnackbar(
                                    text: 'Product already added to cart');
                              },
                              style: ButtonStyle(
                                backgroundColor: const WidgetStatePropertyAll(
                                    kWarninngColor),
                                foregroundColor:
                                    const WidgetStatePropertyAll(Colors.white),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        widget.constraints.maxWidth < 768
                                            ? 8
                                            : 14),
                                  ),
                                ),
                              ),
                              icon: Icon(
                                Iconsax.shopping_cart,
                                color: Colors.white,
                                size:
                                    widget.constraints.maxWidth < 768 ? 20 : 25,
                              ),
                            )
                          : IconButton(
                              onPressed: () async {
                                await cartController.addToCart(
                                  productId: widget.products.id,
                                  quantity: '1',
                                );
                                await productsController.getProducts();
                                setState(() {});
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    const WidgetStatePropertyAll(kPrimaryColor),
                                foregroundColor:
                                    const WidgetStatePropertyAll(Colors.white),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        widget.constraints.maxWidth < 768
                                            ? 8
                                            : 14),
                                  ),
                                ),
                              ),
                              icon: Icon(
                                Iconsax.shopping_cart,
                                color: Colors.white,
                                size:
                                    widget.constraints.maxWidth < 768 ? 20 : 25,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              widget.products.discount == 'N/A'
                  ? const SizedBox.shrink()
                  : Positioned(
                      top: widget.constraints.maxWidth < 768 ? 5 : 10,
                      left: widget.constraints.maxWidth < 768 ? 5 : 10,
                      child: Container(
                        height: widget.constraints.maxWidth < 768 ? 23 : 30,
                        // width: 45,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          color: kSecondaryColor,
                        ),
                        child: Text(
                          '${widget.products.discount} off',
                          style: TextStyle(
                            fontSize:
                                widget.constraints.maxWidth < 768 ? 12 : 24,
                            color: kContentColorDarkTheme,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              widget.products.name,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: widget.constraints.maxWidth < 768 ? 14 : 25,
                fontWeight: FontWeight.w500,
                color: kContentColorLightTheme,
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: widget.constraints.maxWidth < 768 ? 5 : 10),
                  child: Text(
                    currency.format(widget.products.convertedPrice),
                    style: TextStyle(
                      fontSize: widget.constraints.maxWidth < 768 ? 17 : 25,
                      fontWeight: FontWeight.w700,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Padding(
          //   padding: EdgeInsets.only(
          //       top: widget.constraints.maxWidth < 768 ? 3 : 10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         widget.products.inCart,
          //         style: TextStyle(
          //           fontSize: (widget.constraints.maxWidth < 768) ? 12 : 24,
          //           color: kContentColorLightTheme.withOpacity(0.5),
          //         ),
          //       ),
          //       // const SizedBox(width: 70),

          //       // InkWell(
          //       //   onTap: () {
          //       //   },
          //       //   child: Container(
          //       //     height: widget.constraints.maxWidth < 768 ? 30 : 60,
          //       //     width: widget.constraints.maxWidth < 768 ? 30 : 60,
          //       //     decoration: BoxDecoration(
          //       //       color: kPrimaryColor,
          //       //       borderRadius: BorderRadius.all(Radius.circular(
          //       //           widget.constraints.maxWidth < 768 ? 8 : 14)),
          //       //     ),
          //       //     child: Center(
          //       //       child: Icon(
          //       //         Iconsax.shopping_cart,
          //       //         color: Colors.white,
          //       //         size: widget.constraints.maxWidth < 768 ? 20 : 25,
          //       //       ),
          //       //     ),
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
