import 'package:animate_do/animate_do.dart';
import 'package:duapa/controllers/product_controller.dart';
import 'package:duapa/views/home/widgets/product_card.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../widgets/empty.dart';
import '../widgets/loading_widget.dart';

class ProductCategoryScreen extends StatefulWidget {
  const ProductCategoryScreen(
      {super.key, required this.id, required this.categoryName});
  final String id;
  final String categoryName;

  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  final ProductsController _productsController = Get.find();

  @override
  void initState() {
    // _productsController.getProductsbyCategory(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: widget.categoryName),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return FadeInDown(
            from: 30,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child:

                  // GetBuilder<ProductsController>(
                  //   initState: (state) {
                  //     _productsController.getProductsbyCategory(widget.id);
                  //   },
                  //   builder: (controller) {
                  //     return controller.isLoading.isTrue
                  //         ? const AbyLoading()
                  //         : controller.catProducts.value.value == null
                  //             ? const EmptyWidget(text: 'Category Empty.')
                  //             : MasonryGridView.count(
                  //                 padding:
                  //                     const EdgeInsets.only(top: 15, bottom: 10),
                  //                 crossAxisCount:
                  //                     constraints.maxWidth < 768 ? 2 : 3,
                  //                 mainAxisSpacing: 15,
                  //                 crossAxisSpacing: 15,
                  //                 itemCount:
                  //                     controller.catProducts.value.value!.length,
                  //                 physics: const NeverScrollableScrollPhysics(),
                  //                 shrinkWrap: true,
                  //                 itemBuilder: (context, index) {
                  //                   return ProductCard(
                  //                     products: controller
                  //                         .catProducts.value.value![index],
                  //                     constraints: constraints,
                  //                     isDetailScreen: false,
                  //                   );
                  //                 },
                  //               );
                  //   },
                  // ),

                  //     Obx(
                  //   () => _productsController.isLoading.isTrue
                  //       ? const AbyLoading()
                  //       : _productsController.catProducts.value.value == null
                  //           ? const EmptyWidget(text: 'Category Empty.')
                  //           : MasonryGridView.count(
                  //               padding: const EdgeInsets.only(top: 15, bottom: 10),
                  //               crossAxisCount: constraints.maxWidth < 768 ? 2 : 3,
                  //               mainAxisSpacing: 15,
                  //               crossAxisSpacing: 15,
                  //               itemCount: _productsController
                  //                   .catProducts.value.value!.length,
                  //               physics: const NeverScrollableScrollPhysics(),
                  //               shrinkWrap: true,
                  //               itemBuilder: (context, index) {
                  //                 return ProductCard(
                  //                   products: _productsController
                  //                       .catProducts.value.value![index],
                  //                   constraints: constraints,
                  //                   isDetailScreen: false,
                  //                 );
                  //               },
                  //             ),
                  // ),

                  FutureBuilder(
                future: _productsController.getProductsbyCategory(widget.id),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const AbyLoading();
                    case ConnectionState.none:
                      return const EmptyWidget(
                          text: 'No Products at the moment!');
                    case ConnectionState.active:
                      return const AbyLoading();
                    case ConnectionState.done:
                      return _productsController.message ==
                              'no products available'
                          ? const EmptyWidget(
                              text: 'No products in this category')
                          : MasonryGridView.count(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 10),
                              crossAxisCount:
                                  constraints.maxWidth < 768 ? 2 : 3,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              itemCount: snapshot.data!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  products: snapshot.data![index],
                                  constraints: constraints,
                                  isDetailScreen: false,
                                );
                              },
                            );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
