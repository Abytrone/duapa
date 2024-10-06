import 'package:duapa/services/product_services.dart';
import 'package:duapa/views/widgets/empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../models/products_model.dart';
import '../../responsive_helper.dart';
import '../../services/constants.dart';
import '../../services/theme.dart';
import '../account/product/add_product_form.dart';
import 'widgets/farmer_product_card.dart';
import 'widgets/product_shimmer.dart';

class FarmerProductScreen extends StatefulWidget {
  const FarmerProductScreen({super.key});

  @override
  State<FarmerProductScreen> createState() => _FarmerProductScreenState();
}

class _FarmerProductScreenState extends State<FarmerProductScreen> {
  final ProductServices _productServices = ProductServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LayoutBuilder(builder: (context, constraints) {
          return Text(
            'My Products',
            style: TextStyle(
              fontSize: constraints.maxWidth < 768 ? 12 : 17,
              color: Theme.of(context).brightness ==
                      lightThemeData(context).brightness
                  ? kContentColorLightTheme
                  : kContentColorDarkTheme,
            ),
          );
        }),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const AddProduct());
            },
            icon: const Icon(
              Iconsax.add_square,
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor:
            Theme.of(context).brightness == lightThemeData(context).brightness
                ? kContentColorDarkTheme
                : kContentColorLightTheme,
        iconTheme: IconThemeData(
          color:
              Theme.of(context).brightness == lightThemeData(context).brightness
                  ? kContentColorLightTheme
                  : kContentColorDarkTheme,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return FutureBuilder(
            future: _productServices.getFarmerProducts(),
            builder: (context, AsyncSnapshot<Products> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ResponsiveHelper(
                  mobile: ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return ProductShimmer(
                          constraints: constraints,
                        );
                      }),
                  tablet: MasonryGridView.count(
                    padding: const EdgeInsets.all(10),
                    crossAxisCount: 2,
                    itemCount: 7,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ProductShimmer(
                        constraints: constraints,
                      );
                    },
                  ),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data!.message != null) {
                  return const EmptyWidget(
                      text: 'You haven\'t added any products yet');
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        return FarmerProductCard(
                          product: snapshot.data!.data![index],
                        );
                      },
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                // print(snapshot.error);
                return const Center(
                  child: Text('Error loading data!'),
                );
              } else {
                return const Center(
                  child: Text('No Data!'),
                );
              }
            },
          );
        },
      ),
    );
  }
}
