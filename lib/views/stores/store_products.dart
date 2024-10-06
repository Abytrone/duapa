import 'package:animate_do/animate_do.dart';
import 'package:duapa/services/product_services.dart';
import 'package:duapa/views/home/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/products_model.dart';
import '../../services/constants.dart';
import '../../services/theme.dart';

class StoreProductsScreen extends StatefulWidget {
  const StoreProductsScreen({
    super.key,
    required this.productId,
    required this.storeName,
    required this.storeImage,
  });
  final String productId;
  final String storeName;
  final String storeImage;

  @override
  State<StoreProductsScreen> createState() => _StoreProductsScreenState();
}

class _StoreProductsScreenState extends State<StoreProductsScreen> {
  final ProductServices productServices = ProductServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Hero(
      //     transitionOnUserGestures: true,
      //     tag: 'TitleTag${widget.productId}',
      //     child: Text(
      //       widget.storeName,
      //       style: TextStyle(
      //         fontSize: 12,
      //         color: Theme.of(context).brightness ==
      //                 lightThemeData(context).brightness
      //             ? kContentColorLightTheme
      //             : kContentColorDarkTheme,
      //       ),
      //     ),
      //   ),
      //   centerTitle: true,
      //   backgroundColor:
      //       Theme.of(context).brightness == lightThemeData(context).brightness
      //           ? kContentColorDarkTheme
      //           : kContentColorLightTheme,
      //   iconTheme: IconThemeData(
      //     color:
      //         Theme.of(context).brightness == lightThemeData(context).brightness
      //             ? kContentColorLightTheme
      //             : kContentColorDarkTheme,
      //   ),
      // ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.user),
                  ),
                ],
                expandedHeight: 150,
                backgroundColor: Theme.of(context).brightness ==
                        lightThemeData(context).brightness
                    ? kContentColorDarkTheme
                    : kContentColorLightTheme,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.all(0),
                  title: Container(
                    height: 150,
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 10),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.7, 1],
                        colors: [
                          Colors.black12,
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                    child: Text(
                      widget.storeName,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  background: Hero(
                    tag: 'TitleTag${widget.productId}',
                    child: FadeInImage.assetNetwork(
                      // height: constraints.maxWidth < 768 ? 70 : 130,
                      // width: constraints.maxWidth < 768 ? 70 : 130,
                      // placeholderCacheHeight: constraints.maxWidth < 768 ? 70 : 130,
                      // placeholderCacheWidth: constraints.maxWidth < 768 ? 70 : 130,
                      placeholder: 'assets/img/placeholder.png',
                      image: widget.storeImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                child: FutureBuilder<Products>(
                  future: ProductServices.fetchStoreProductsByUserID(
                      id: widget.productId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: GridView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                          ),
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade50,
                              highlightColor: Colors.grey.shade200,
                              child: Container(
                                height: 250,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasData) {
                      if (snapshot.data!.message != null) {
                        return const Center(
                          child: Text('No products'),
                        );
                      } else {
                        return FadeInDown(
                          from: 30,
                          child: MasonryGridView.count(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 10),
                              crossAxisCount: 2,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              itemCount: snapshot.data!.data!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return ProductCard(
                                  products: snapshot.data!.data![index],
                                  constraints: constraints,
                                  isDetailScreen: false,
                                );
                              }),
                        );
                      }
                    } else {
                      return const Center(
                        child: Text('Error loading products'),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
      // LayoutBuilder(builder: (context, constraints) {
      //   return FutureBuilder<Products>(
      //     future:
      //         ProductServices.fetchStoreProductsByUserID(id: widget.productId),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return Padding(
      //           padding: const EdgeInsets.only(top: 15.0),
      //           child: GridView.builder(
      //             itemCount: 10,
      //             shrinkWrap: true,
      //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //               crossAxisCount: 2,
      //               crossAxisSpacing: 5.0,
      //               mainAxisSpacing: 5.0,
      //             ),
      //             itemBuilder: (context, index) {
      //               return Shimmer.fromColors(
      //                 baseColor: Colors.grey.shade50,
      //                 highlightColor: Colors.grey.shade200,
      //                 child: Container(
      //                   height: 250,
      //                   decoration: const BoxDecoration(
      //                     color: Colors.white,
      //                     borderRadius: BorderRadius.all(Radius.circular(10)),
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //         );
      //       } else if (snapshot.hasData) {
      //         if (snapshot.data!.message != null) {
      //           return const Center(
      //             child: Text('No products'),
      //           );
      //         } else {
      //           return FadeInDown(
      //             from: 30,
      //             child: MasonryGridView.count(
      //                 padding: const EdgeInsets.only(top: 15, bottom: 10),
      //                 crossAxisCount: 2,
      //                 mainAxisSpacing: 15,
      //                 crossAxisSpacing: 15,
      //                 itemCount: snapshot.data!.data!.length,
      //                 physics: const NeverScrollableScrollPhysics(),
      //                 shrinkWrap: true,
      //                 itemBuilder: (BuildContext context, int index) {
      //                   return ProductCard(
      //                     products: snapshot.data!.data![index],
      //                     constraints: constraints,
      //                   );
      //                 }),
      //           );
      //         }
      //       } else {
      //         return const Center(
      //           child: Text('Error loading products'),
      //         );
      //       }
      //     },
      //   );
      // },),
    );
  }
}
