import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/product_services.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/home/product_seller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../models/product_details_class.dart';
import 'widgets/product_card.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.productId});
  final String productId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // final currency = NumberFormat.simpleCurrency(locale: 'en_US', name: 'Ghc');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return FutureBuilder<ProductDetails?>(
            future: ProductServices.getProductDetails(id: widget.productId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final currency = NumberFormat.simpleCurrency(
                      locale: 'en_US',
                      name: snapshot.data!.data.convertedCurrencyCode);
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            // Back button
                            CarouselSlider(
                              options: CarouselOptions(
                                height: MediaQuery.of(context).size.height / 3,
                                viewportFraction: 1.0,
                                enlargeCenterPage: true,
                                disableCenter: false,
                                // autoPlay: false,
                              ),
                              items: snapshot.data!.data.pictureGallery
                                  .map(
                                    (item) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30),
                                        ),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(item.url),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            Positioned(
                              top: 50,
                              left: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          lightThemeData(context).brightness
                                      ? kContentColorDarkTheme
                                      : kContentColorLightTheme,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(context);
                                  },
                                  icon: Icon(
                                    Icons.chevron_left,
                                    color: Theme.of(context).brightness ==
                                            lightThemeData(context).brightness
                                        ? kContentColorLightTheme
                                        : kContentColorDarkTheme,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).brightness ==
                                          lightThemeData(context).brightness
                                      ? kContentColorLightTheme.withOpacity(0.3)
                                      : kContentColorDarkTheme.withOpacity(0.5),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!.data.name,
                                    maxLines: 2,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              lightThemeData(context).brightness
                                          ? kContentColorLightTheme
                                          : kContentColorDarkTheme,
                                      fontSize:
                                          constraints.maxWidth < 768 ? 17 : 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Text(
                                        currency.format(
                                            snapshot.data!.data.convertedPrice),
                                        // currency.format(
                                        //     snapshot.data!.data.price),
                                        style: TextStyle(
                                          fontSize: constraints.maxWidth < 768
                                              ? 20
                                              : 30,
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   width: 10,
                                      // ),
                                      // Text(
                                      //   ' 500.00',
                                      //   style: TextStyle(
                                      //     fontSize: 13,
                                      //     decoration: TextDecoration.lineThrough,
                                      //     color: Theme.of(context).brightness ==
                                      //             lightThemeData(context).brightness
                                      //         ? kContentColorLightTheme.withOpacity(0.3)
                                      //         : kContentColorDarkTheme.withOpacity(0.5),
                                      //   ),
                                      // ),
                                      const SizedBox(width: 10),
                                      snapshot.data!.data.discount == 'N/A'
                                          ? Container()
                                          : Text(
                                              '${snapshot.data!.data.discount}% off',
                                              style: TextStyle(
                                                fontSize:
                                                    constraints.maxWidth < 768
                                                        ? 17
                                                        : 24,
                                                color: kErrorColor,
                                              ),
                                            ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Price > inclusive of all taxes',
                                        style: TextStyle(
                                          fontSize: constraints.maxWidth < 768
                                              ? 12
                                              : 20,
                                          color: Theme.of(context).brightness ==
                                                  lightThemeData(context)
                                                      .brightness
                                              ? kContentColorLightTheme
                                                  .withOpacity(0.5)
                                              : kContentColorDarkTheme
                                                  .withOpacity(0.5),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Text(
                                          snapshot.data!.data.deliveryMode,
                                          style: TextStyle(
                                            color: kContentColorDarkTheme,
                                            fontSize: constraints.maxWidth < 768
                                                ? 10
                                                : 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Divider(
                                      height: 5,
                                      color: Theme.of(context).brightness ==
                                              lightThemeData(context).brightness
                                          ? kContentColorLightTheme
                                              .withOpacity(0.5)
                                          : kContentColorDarkTheme
                                              .withOpacity(0.5),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Row(
                                      //   children: [
                                      //     // Reduce quantity button
                                      //     Container(
                                      //       height: 25,
                                      //       width: 25,
                                      //       alignment: Alignment.center,
                                      //       decoration: BoxDecoration(
                                      //         color: kErrorColor,
                                      //         shape: BoxShape.circle,
                                      //       ),
                                      //       child: IconButton(
                                      //         padding: const EdgeInsets.all(0),
                                      //         onPressed: () {
                                      //           _productsController.decreaseQuantity();
                                      //         },
                                      //         iconSize: 20,
                                      //         icon: Icon(
                                      //           Icons.remove,
                                      //           color: kContentColorDarkTheme,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     // Quantity
                                      //     Padding(
                                      //       padding: const EdgeInsets.symmetric(
                                      //           horizontal: 8.0),
                                      //       child: Obx(() {
                                      //         return Text(
                                      //           _productsController.quantity.string,
                                      //           style: TextStyle(
                                      //             fontSize: 20,
                                      //             color: Theme.of(context).brightness ==
                                      //                     lightThemeData(context)
                                      //                         .brightness
                                      //                 ? kContentColorLightTheme
                                      //                 : kContentColorDarkTheme,
                                      //           ),
                                      //         );
                                      //       }),
                                      //     ),
                                      //     // Add quantity button
                                      //     Container(
                                      //       height: 25,
                                      //       width: 25,
                                      //       alignment: Alignment.center,
                                      //       decoration: BoxDecoration(
                                      //         color: kPrimaryColor,
                                      //         shape: BoxShape.circle,
                                      //       ),
                                      //       child: IconButton(
                                      //         padding: const EdgeInsets.all(0),
                                      //         onPressed: () {
                                      //           _productsController.increaseQuantity();
                                      //         },
                                      //         iconSize: 20,
                                      //         icon: Icon(
                                      //           Icons.add,
                                      //           color: kContentColorDarkTheme,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return SellerScreen(
                                              sellerId:
                                                  snapshot.data!.data.postedBy,
                                            );
                                          }));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: kPrimaryColor,
                                        ),
                                        icon: const Icon(
                                          Iconsax.eye,
                                          color: kContentColorDarkTheme,
                                          size: 20,
                                        ),
                                        label: Text(
                                          'Seller',
                                          style: TextStyle(
                                            fontSize: constraints.maxWidth < 768
                                                ? 12
                                                : 20,
                                            color: kContentColorDarkTheme,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 0.3,
                                        color: Theme.of(context).brightness ==
                                                lightThemeData(context)
                                                    .brightness
                                            ? kContentColorLightTheme
                                                .withOpacity(0.5)
                                            : kContentColorDarkTheme
                                                .withOpacity(0.5),
                                      ),
                                      // ElevatedButton(
                                      //   onPressed: () {
                                      //   },
                                      //   child: Text(
                                      //     'See Profile',
                                      //     style: TextStyle(
                                      //       color: kContentColorDarkTheme,
                                      //       fontWeight: FontWeight.bold,
                                      //     ),
                                      //   ),
                                      // ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Estimated Delivery:',
                                            style: TextStyle(
                                                fontSize:
                                                    constraints.maxWidth < 768
                                                        ? 12
                                                        : 20),
                                          ),
                                          Text(
                                            '5-7 days',
                                            style: TextStyle(
                                              fontSize:
                                                  constraints.maxWidth < 768
                                                      ? 12
                                                      : 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(top: 10.0, bottom: 5),
                            //   child: Text(
                            //     'Key Highlights:',
                            //     style: TextStyle(
                            //       fontSize:
                            //           constraints.maxWidth < 768 ? 17 : 25,
                            //       fontWeight: FontWeight.bold,
                            //       color: Theme.of(context).brightness ==
                            //               lightThemeData(context).brightness
                            //           ? kContentColorLightTheme
                            //           : kContentColorDarkTheme,
                            //     ),
                            //   ),
                            // ),
                            // // Key Highlights Table
                            // Table(
                            //   // defaultColumnWidth: FixedColumnWidth(120.0),
                            //   border: TableBorder.all(
                            //     width: 1,
                            //     borderRadius: const BorderRadius.all(
                            //         Radius.circular(10)),
                            //     color: Theme.of(context).brightness ==
                            //             lightThemeData(context).brightness
                            //         ? kContentColorLightTheme.withOpacity(0.3)
                            //         : kContentColorDarkTheme.withOpacity(0.3),
                            //   ),
                            //   children: [
                            //     TableRow(
                            //       children: [
                            //         Column(
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.start,
                            //             children: [
                            //               Padding(
                            //                 padding:
                            //                     const EdgeInsets.symmetric(
                            //                         vertical: 5.0,
                            //                         horizontal: 10),
                            //                 child: Text(
                            //                   'Sowing Season',
                            //                   style: TextStyle(
                            //                     fontSize: 15.0,
                            //                     fontWeight: FontWeight.bold,
                            //                     color: Theme.of(context)
                            //                                 .brightness ==
                            //                             lightThemeData(
                            //                                     context)
                            //                                 .brightness
                            //                         ? kContentColorLightTheme
                            //                         : kContentColorDarkTheme,
                            //                   ),
                            //                 ),
                            //               )
                            //             ]),
                            //         Column(
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.start,
                            //             children: [
                            //               Padding(
                            //                 padding:
                            //                     const EdgeInsets.symmetric(
                            //                         vertical: 5.0,
                            //                         horizontal: 10),
                            //                 child: Text(
                            //                   snapshot.data!.data
                            //                       .keyHighlights.sowingSeason,
                            //                   style: TextStyle(
                            //                     fontSize: 15.0,
                            //                     color: Theme.of(context)
                            //                                 .brightness ==
                            //                             lightThemeData(
                            //                                     context)
                            //                                 .brightness
                            //                         ? kContentColorLightTheme
                            //                         : kContentColorDarkTheme,
                            //                   ),
                            //                 ),
                            //               )
                            //             ]),
                            //       ],
                            //     ),
                            //     TableRow(children: [
                            //       Column(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: [
                            //             Padding(
                            //               padding: const EdgeInsets.symmetric(
                            //                   vertical: 5.0, horizontal: 10),
                            //               child: Text('Sowing Method',
                            //                   style: TextStyle(
                            //                     fontSize: 15.0,
                            //                     fontWeight: FontWeight.bold,
                            //                     color: Theme.of(context)
                            //                                 .brightness ==
                            //                             lightThemeData(
                            //                                     context)
                            //                                 .brightness
                            //                         ? kContentColorLightTheme
                            //                         : kContentColorDarkTheme,
                            //                   )),
                            //             )
                            //           ]),
                            //       Column(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: [
                            //             Padding(
                            //               padding: const EdgeInsets.symmetric(
                            //                   vertical: 5.0, horizontal: 10),
                            //               child: Text(
                            //                   snapshot.data!.data
                            //                       .keyHighlights.sowingMethod,
                            //                   style: TextStyle(
                            //                     fontSize: 15.0,
                            //                     color: Theme.of(context)
                            //                                 .brightness ==
                            //                             lightThemeData(
                            //                                     context)
                            //                                 .brightness
                            //                         ? kContentColorLightTheme
                            //                         : kContentColorDarkTheme,
                            //                   )),
                            //             )
                            //           ]),
                            //     ]),
                            //     TableRow(children: [
                            //       Column(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: [
                            //             Padding(
                            //               padding: const EdgeInsets.symmetric(
                            //                   vertical: 5.0, horizontal: 10),
                            //               child: Text('Sowing Spacing',
                            //                   style: TextStyle(
                            //                     fontSize: 15.0,
                            //                     fontWeight: FontWeight.bold,
                            //                     color: Theme.of(context)
                            //                                 .brightness ==
                            //                             lightThemeData(
                            //                                     context)
                            //                                 .brightness
                            //                         ? kContentColorLightTheme
                            //                         : kContentColorDarkTheme,
                            //                   )),
                            //             )
                            //           ]),
                            //       Column(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: [
                            //             Padding(
                            //               padding: const EdgeInsets.symmetric(
                            //                   vertical: 5.0, horizontal: 10),
                            //               child: Text(
                            //                   snapshot
                            //                       .data!
                            //                       .data
                            //                       .keyHighlights
                            //                       .sowingSpacing,
                            //                   style: TextStyle(
                            //                     fontSize: 15.0,
                            //                     color: Theme.of(context)
                            //                                 .brightness ==
                            //                             lightThemeData(
                            //                                     context)
                            //                                 .brightness
                            //                         ? kContentColorLightTheme
                            //                         : kContentColorDarkTheme,
                            //                   )),
                            //             )
                            //           ]),
                            //     ]),
                            //     TableRow(children: [
                            //       Column(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: [
                            //             Padding(
                            //               padding: const EdgeInsets.symmetric(
                            //                   vertical: 5.0, horizontal: 10),
                            //               child: Text('First Harvest',
                            //                   style: TextStyle(
                            //                     fontSize: 15.0,
                            //                     fontWeight: FontWeight.bold,
                            //                     color: Theme.of(context)
                            //                                 .brightness ==
                            //                             lightThemeData(
                            //                                     context)
                            //                                 .brightness
                            //                         ? kContentColorLightTheme
                            //                         : kContentColorDarkTheme,
                            //                   )),
                            //             )
                            //           ]),
                            //       Column(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: [
                            //             Padding(
                            //               padding: const EdgeInsets.symmetric(
                            //                   vertical: 5.0, horizontal: 10),
                            //               child: Text(
                            //                   snapshot.data!.data
                            //                       .keyHighlights.firstHarvest,
                            //                   style: TextStyle(
                            //                     fontSize: 15.0,
                            //                     color: Theme.of(context)
                            //                                 .brightness ==
                            //                             lightThemeData(
                            //                                     context)
                            //                                 .brightness
                            //                         ? kContentColorLightTheme
                            //                         : kContentColorDarkTheme,
                            //                   )),
                            //             )
                            //           ]),
                            //     ]),
                            //     TableRow(children: [
                            //       Column(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: [
                            //             Padding(
                            //               padding: const EdgeInsets.symmetric(
                            //                   vertical: 5.0, horizontal: 10),
                            //               child: Text('Special Remark',
                            //                   style: TextStyle(
                            //                     fontSize: 15.0,
                            //                     fontWeight: FontWeight.bold,
                            //                     color: Theme.of(context)
                            //                                 .brightness ==
                            //                             lightThemeData(
                            //                                     context)
                            //                                 .brightness
                            //                         ? kContentColorLightTheme
                            //                         : kContentColorDarkTheme,
                            //                   )),
                            //             )
                            //           ]),
                            //       Column(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: [
                            //             Padding(
                            //               padding: const EdgeInsets.symmetric(
                            //                   vertical: 5.0, horizontal: 10),
                            //               child: Text(
                            //                   snapshot
                            //                       .data!
                            //                       .data
                            //                       .keyHighlights
                            //                       .specialRemark,
                            //                   style: TextStyle(
                            //                     fontSize: 15.0,
                            //                     color: Theme.of(context)
                            //                                 .brightness ==
                            //                             lightThemeData(
                            //                                     context)
                            //                                 .brightness
                            //                         ? kContentColorLightTheme
                            //                         : kContentColorDarkTheme,
                            //                   )),
                            //             )
                            //           ]),
                            //     ]),
                            //   ],
                            // ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Description:',
                                style: TextStyle(
                                  fontSize:
                                      constraints.maxWidth < 768 ? 17 : 25,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness ==
                                          lightThemeData(context).brightness
                                      ? kContentColorLightTheme
                                      : kContentColorDarkTheme,
                                ),
                              ),
                            ),
                            Text(
                              snapshot.data!.data.keyHighlights.description,
                              style: TextStyle(
                                fontSize: constraints.maxWidth < 768 ? 12 : 25,
                                color: Theme.of(context).brightness ==
                                        lightThemeData(context).brightness
                                    ? kContentColorLightTheme
                                    : kContentColorDarkTheme,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Related Products:',
                                style: TextStyle(
                                  fontSize:
                                      constraints.maxWidth < 768 ? 17 : 25,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness ==
                                          lightThemeData(context).brightness
                                      ? kContentColorLightTheme
                                      : kContentColorDarkTheme,
                                ),
                              ),
                            ),
                            // Related products section

                            Container(
                              padding:
                                  const EdgeInsets.only(bottom: 20, right: 10),
                              // height: constraints.maxWidth < 768 ? 300 : 500,
                              width: Get.size.width,
                              child: MasonryGridView.count(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 10),
                                crossAxisCount:
                                    constraints.maxWidth < 768 ? 2 : 3,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 15,
                                itemCount:
                                    snapshot.data!.data.relatedProducts.length,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  // return const Text('Product');
                                  return ProductCard(
                                    products: snapshot
                                        .data!.data.relatedProducts[index],
                                    constraints: constraints,
                                    isDetailScreen: true,
                                  );
                                },
                              ),

                              //     ListView.builder(
                              //   itemCount:
                              //       snapshot.data!.data.relatedProducts.length,
                              //   scrollDirection: Axis.horizontal,
                              //   itemBuilder: (context, index) {
                              //     return ProductCard(
                              //       products: snapshot
                              //           .data!.data.relatedProducts[index],
                              //       constraints: constraints,
                              //       isDetailScreen: true,
                              //     );
                              //   },
                              // ),
                            ),
                            FadeInDown(
                              from: 30,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Drivers Available:',
                                  style: TextStyle(
                                    fontSize:
                                        constraints.maxWidth < 768 ? 17 : 25,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).brightness ==
                                            lightThemeData(context).brightness
                                        ? kContentColorLightTheme
                                        : kContentColorDarkTheme,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // TabBar(
                      //   controller: _tabController,
                      //   unselectedLabelColor: kContentColorLightTheme,
                      //   padding: const EdgeInsets.all(10),
                      //   indicator: const BoxDecoration(
                      //     color: kContentColorLightTheme,
                      //     borderRadius: BorderRadius.all(Radius.circular(10)),
                      //   ),
                      //   tabs: [
                      //     Padding(
                      //       padding: const EdgeInsets.all(10.0),
                      //       child: Text(
                      //         'City',
                      //         style: TextStyle(
                      //             fontSize:
                      //                 constraints.maxWidth < 768 ? 12 : 17,
                      //             fontFamily: 'Gotik'),
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.all(10.0),
                      //       child: Text(
                      //         'Region',
                      //         style: TextStyle(
                      //             fontSize:
                      //                 constraints.maxWidth < 768 ? 12 : 17,
                      //             fontFamily: 'Gotik'),
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.all(10.0),
                      //       child: Text(
                      //         'Country',
                      //         style: TextStyle(
                      //             fontSize:
                      //                 constraints.maxWidth < 768 ? 12 : 17,
                      //             fontFamily: 'Gotik'),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 300,
                      //   child: TabBarView(
                      //     controller: _tabController,
                      //     children: [
                      //       // --------------------LIST-OF-CITIES-------------------------

                      //       Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 20, vertical: 20),
                      //         child: ListView.builder(
                      //           padding: const EdgeInsets.symmetric(
                      //               horizontal: 10),
                      //           itemCount: snapshot
                      //               .data!.data.drivers.withinCity.length,
                      //           itemBuilder:
                      //               (BuildContext context, int index) {
                      //             return snapshot.data!.data.drivers
                      //                         .withinCity[index].message ==
                      //                     'No drivers'
                      //                 ? Center(
                      //                     child: Text(
                      //                       'No drivers available',
                      //                       style: TextStyle(
                      //                         fontSize:
                      //                             constraints.maxWidth < 768
                      //                                 ? 12
                      //                                 : 17,
                      //                       ),
                      //                     ),
                      //                   )
                      //                 : FadeInDown(
                      //                     from: 30,
                      //                     child: Padding(
                      //                       padding:
                      //                           const EdgeInsets.symmetric(
                      //                               vertical: 5.0),
                      //                       child: Container(
                      //                         padding:
                      //                             const EdgeInsets.all(5),
                      //                         decoration: const BoxDecoration(
                      //                           borderRadius:
                      //                               BorderRadius.all(
                      //                             Radius.circular(8),
                      //                           ),
                      //                           color: Colors.white,
                      //                           boxShadow: [
                      //                             BoxShadow(
                      //                               blurRadius: 10.0,
                      //                               color: Colors.black12,
                      //                             ),
                      //                           ],
                      //                         ),
                      //                         child: ListTile(
                      //                           onTap: () {
                      //                             Navigator.of(context).push(
                      //                               MaterialPageRoute(
                      //                                 builder: (context) =>
                      //                                     ProductDriverScreen(
                      //                                   driver: snapshot
                      //                                           .data!
                      //                                           .data
                      //                                           .drivers
                      //                                           .withinCity[
                      //                                       index],
                      //                                 ),
                      //                               ),
                      //                             );
                      //                           },
                      //                           leading: const CircleAvatar(
                      //                             backgroundImage: AssetImage(
                      //                                 'assets/img/people.png'),
                      //                           ),
                      //                           title: Text(
                      //                             '${snapshot.data!.data.drivers.withinCity[index].firstName!} ${snapshot.data!.data.drivers.withinCity[index].surname!}',
                      //                             style: const TextStyle(
                      //                               fontWeight:
                      //                                   FontWeight.bold,
                      //                             ),
                      //                           ),
                      //                           subtitle: Text(
                      //                             snapshot
                      //                                 .data!
                      //                                 .data
                      //                                 .drivers
                      //                                 .withinCity[index]
                      //                                 .phoneNumber!,
                      //                             style: TextStyle(
                      //                               fontSize:
                      //                                   constraints.maxWidth <
                      //                                           768
                      //                                       ? 12
                      //                                       : 17,
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   );
                      //           },
                      //         ),
                      //       ),
                      //       // --------------------LIST-OF-REGIONS-------------------------
                      //       Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 20, vertical: 20),
                      //         child: ListView.builder(
                      //           padding: const EdgeInsets.symmetric(
                      //               horizontal: 10),
                      //           itemCount: snapshot
                      //               .data!.data.drivers.withinRegion.length,
                      //           itemBuilder:
                      //               (BuildContext context, int index) {
                      //             return snapshot.data!.data.drivers
                      //                         .withinRegion[index].message ==
                      //                     'No drivers'
                      //                 ? const Center(
                      //                     child: Text('No drivers available'),
                      //                   )
                      //                 : FadeInDown(
                      //                     from: 30,
                      //                     child: Padding(
                      //                       padding:
                      //                           const EdgeInsets.symmetric(
                      //                               vertical: 5.0),
                      //                       child: Container(
                      //                         padding:
                      //                             const EdgeInsets.all(5),
                      //                         decoration: const BoxDecoration(
                      //                           borderRadius:
                      //                               BorderRadius.all(
                      //                             Radius.circular(8),
                      //                           ),
                      //                           color: Colors.white,
                      //                           boxShadow: [
                      //                             BoxShadow(
                      //                               blurRadius: 10.0,
                      //                               color: Colors.black12,
                      //                             ),
                      //                           ],
                      //                         ),
                      //                         child: ListTile(
                      //                           leading: const CircleAvatar(
                      //                             backgroundImage: AssetImage(
                      //                                 'assets/img/people.png'),
                      //                           ),
                      //                           trailing: IconButton(
                      //                             onPressed: () {
                      //                               // Navigator.of(context).push(
                      //                               //   MaterialPageRoute(
                      //                               //     builder: (context) =>
                      //                               //         CoporateGroupDetailScreen(
                      //                               //       group: widget.group.members[index].farmers[0],
                      //                               //     ),
                      //                               //   ),
                      //                               // );
                      //                             },
                      //                             icon: const Icon(
                      //                                 FontAwesomeIcons
                      //                                     .angleRight),
                      //                           ),
                      //                           title: Text(
                      //                             '${snapshot.data!.data.drivers.withinRegion[index].firstName!} ${snapshot.data!.data.drivers.withinRegion[index].surname!}',
                      //                             style: const TextStyle(
                      //                               fontWeight:
                      //                                   FontWeight.bold,
                      //                             ),
                      //                           ),
                      //                           subtitle: Text(
                      //                             snapshot
                      //                                 .data!
                      //                                 .data
                      //                                 .drivers
                      //                                 .withinRegion[index]
                      //                                 .phoneNumber!,
                      //                             style: const TextStyle(
                      //                               fontSize: 12,
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   );
                      //           },
                      //         ),
                      //       ),
                      //       // --------------------LIST-OF-COUNTRIES-------------------------
                      //       Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 20, vertical: 20),
                      //         child: ListView.builder(
                      //           padding: const EdgeInsets.symmetric(
                      //               horizontal: 10),
                      //           itemCount: snapshot
                      //               .data!.data.drivers.withinCountry.length,
                      //           itemBuilder:
                      //               (BuildContext context, int index) {
                      //             return snapshot.data!.data.drivers
                      //                         .withinCountry[index].message ==
                      //                     'No drivers'
                      //                 ? const Center(
                      //                     child: Text('No drivers available'),
                      //                   )
                      //                 : FadeInDown(
                      //                     from: 30,
                      //                     child: Padding(
                      //                       padding:
                      //                           const EdgeInsets.symmetric(
                      //                               vertical: 5.0),
                      //                       child: Container(
                      //                         padding:
                      //                             const EdgeInsets.all(5),
                      //                         decoration: const BoxDecoration(
                      //                           borderRadius:
                      //                               BorderRadius.all(
                      //                             Radius.circular(8),
                      //                           ),
                      //                           color: Colors.white,
                      //                           boxShadow: [
                      //                             BoxShadow(
                      //                               blurRadius: 10.0,
                      //                               color: Colors.black12,
                      //                             ),
                      //                           ],
                      //                         ),
                      //                         child: ListTile(
                      //                           leading: const CircleAvatar(
                      //                             backgroundImage: AssetImage(
                      //                                 'assets/img/people.png'),
                      //                           ),
                      //                           title: Text(
                      //                             '${snapshot.data!.data.drivers.withinCountry[index].firstName!} ${snapshot.data!.data.drivers.withinCountry[index].surname!}',
                      //                             style: const TextStyle(
                      //                               fontWeight:
                      //                                   FontWeight.bold,
                      //                             ),
                      //                           ),
                      //                           subtitle: Text(
                      //                             snapshot
                      //                                 .data!
                      //                                 .data
                      //                                 .drivers
                      //                                 .withinCountry[index]
                      //                                 .phoneNumber!,
                      //                             style: const TextStyle(
                      //                               fontSize: 12,
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   );
                      //           },
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text(
                        'There was a problem loading data from the server'),
                  );
                }
              } else {
                return const Center(
                  child: Text('Error loading data'),
                );
              }
            });
      }),
    );
  }
}
