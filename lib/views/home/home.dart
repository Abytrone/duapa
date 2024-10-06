import 'package:animate_do/animate_do.dart';
import 'package:duapa/controllers/product_controller.dart';
import 'package:duapa/controllers/user_controller.dart';
import 'package:duapa/models/group_class.dart';
import 'package:duapa/services/auth_services.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/remote_services.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/home/widgets/ads_widget.dart';
import 'package:duapa/views/home/widgets/categories_card.dart';
import 'package:duapa/views/home/widgets/categories_shimmer.dart';
import 'package:duapa/views/home/widgets/groups_card.dart';
import 'package:duapa/views/home/widgets/product_card.dart';
import 'package:duapa/views/widgets/empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
// import 'package:new_version/new_version.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/ads_class.dart';
import 'widgets/products_grid_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    productsController.getProducts();
    productsController.fetchCategories();
    // final newVersion = NewVersion(androidId: 'com.ics.duapa');
    // advancedStatusCheck(newVersion);
  }

  // advancedStatusCheck(NewVersion newVersion) async {
  //   final status = await newVersion.getVersionStatus();
  //   if (status != null) {
  //     if (status.canUpdate == true) {
  //       newVersion.showUpdateDialog(
  //         context: Get.overlayContext!,
  //         versionStatus: status,
  //         dialogText:
  //             'Current version: ${status.localVersion}\nUpdate version: ${status.storeVersion}\n\n${status.releaseNotes}',
  //       );
  //     }
  //   }
  // }

  final formattedNumber = NumberFormat();
  final ProductsController productsController = Get.find();
  final UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: LayoutBuilder(builder: (context, constraints) {
        return SafeArea(
          bottom: false,
          right: false,
          left: false,
          child: Container(
            color: Theme.of(context).brightness ==
                    lightThemeData(context).brightness
                ? kContentColorDarkTheme
                : kContentColorLightTheme,
            // padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      FadeInUp(
                        from: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Top text
                            Text(
                              'home_top_text'.tr,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: constraints.maxWidth < 768 ? 17 : 25,
                                color: Theme.of(context).brightness ==
                                        lightThemeData(context).brightness
                                    ? kContentColorLightTheme
                                    : kContentColorDarkTheme,
                              ),
                            ),
                            // Notification ICON
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('notification');
                              },
                              iconSize: constraints.maxWidth < 768 ? 24 : 30,
                              icon: const Icon(FontAwesomeIcons.bell),
                            ),
                          ],
                        ),
                      ),
                      // Search bar and filter button
                      FadeInDown(
                        from: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            //Search Bar
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Container(
                                width: constraints.maxWidth < 768
                                    ? MediaQuery.of(context).size.width - 120
                                    : MediaQuery.of(context).size.width - 170,
                                height: constraints.maxWidth < 768 ? 45 : 55,
                                padding: const EdgeInsets.only(left: 15),
                                alignment: AlignmentDirectional.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.0),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 10.0,
                                      color: Colors.black12,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  style: const TextStyle(fontFamily: 'Gotik'),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'home_searchbox_text'.tr,
                                    hintStyle: TextStyle(
                                      fontSize:
                                          constraints.maxWidth < 768 ? 12 : 17,
                                      color: kContentColorLightTheme,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        // Navigator.of(context).pushNamed('coomingsoon');
                                      },
                                      icon: const Icon(
                                        Iconsax.search_normal,
                                        color: Colors.black38,
                                      ),
                                    ),
                                    labelStyle: const TextStyle(
                                      fontSize: 15.0,
                                      color: kContentColorLightTheme,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            FutureBuilder<AuthData>(
                              future: userController.getUser(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: Colors.red,
                                        ),
                                        child: Text(
                                          formattedNumber.format(snapshot
                                              .data!.user!.user.totalFarmers),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: constraints.maxWidth < 768
                                                ? 12
                                                : 17,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'home_subscribers'.tr,
                                        style: TextStyle(
                                          fontSize: constraints.maxWidth < 768
                                              ? 12
                                              : 17,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                //---------------------------------------------------------------
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      setState(() {});
                      return productsController.getProducts();
                    },
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        // Categories section header
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'home_categories'.tr,
                                style: TextStyle(
                                  fontSize:
                                      constraints.maxWidth < 768 ? 12 : 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness ==
                                          lightThemeData(context).brightness
                                      ? kContentColorLightTheme
                                      : kContentColorDarkTheme,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Category section
                        ElasticInRight(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              height: constraints.maxWidth < 768 ? 130 : 200,
                              child: Obx(
                                () => productsController.isLoading.isTrue
                                    ? const CategoriesShimmer()
                                    : productsController
                                                .categoryList.value.value ==
                                            null
                                        ? const EmptyWidget(
                                            text: 'No Categories!')
                                        : ListView.separated(
                                            itemCount: productsController
                                                .categoryList
                                                .value
                                                .value!
                                                .length,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            separatorBuilder: (context, index) {
                                              return Container(
                                                width:
                                                    constraints.maxWidth < 768
                                                        ? 10
                                                        : 20,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        lightThemeData(context)
                                                            .brightness
                                                    ? kContentColorDarkTheme
                                                    : kContentColorLightTheme,
                                              );
                                            },
                                            itemBuilder: (context, index) {
                                              return CategoriesCard(
                                                category: productsController
                                                    .categoryList
                                                    .value
                                                    .value![index],
                                                constraints: constraints,
                                              );
                                            },
                                          ),
                              ),

                              // FutureBuilder<List<Category>?>(
                              //   future: productsController.fetchCategories(),
                              //   builder: (context, snapshot) {
                              //     if (snapshot.connectionState ==
                              //         ConnectionState.waiting) {
                              //       return const CategoriesShimmer();
                              //     } else if (snapshot.hasData) {
                              //       if (snapshot.data == null ||
                              //           snapshot.data!.isEmpty) {
                              //         return const EmptyWidget(
                              //             text: 'No Categories!');
                              //       } else {
                              //         return ListView.separated(
                              //           itemCount: snapshot.data!.length,
                              //           shrinkWrap: true,
                              //           scrollDirection: Axis.horizontal,
                              //           separatorBuilder: (context, index) {
                              //             return Container(
                              //               width: constraints.maxWidth < 768
                              //                   ? 10
                              //                   : 20,
                              //               color: Theme.of(context).brightness ==
                              //                       lightThemeData(context)
                              //                           .brightness
                              //                   ? kContentColorDarkTheme
                              //                   : kContentColorLightTheme,
                              //             );
                              //           },
                              //           itemBuilder: (context, index) {
                              //             return CategoriesCard(
                              //               category: snapshot.data![index],
                              //               constraints: constraints,
                              //             );
                              //           },
                              //         );
                              //       }
                              //     } else {
                              //       return const EmptyWidget(
                              //           text:
                              //               'Error loading categories\nPlease try again!');
                              //     }
                              //   },
                              // ),
                            ),
                          ),
                        ),
                        // Groups section header
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'home_groups'.tr,
                                style: TextStyle(
                                  fontSize:
                                      constraints.maxWidth < 768 ? 12 : 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness ==
                                          lightThemeData(context).brightness
                                      ? kContentColorLightTheme
                                      : kContentColorDarkTheme,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Groups section
                        ElasticInLeft(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              height: constraints.maxWidth < 768 ? 120 : 200,
                              child: GridView.builder(
                                itemCount: userController
                                                .user.value.value!.user.role ==
                                            'Extension Officer' ||
                                        userController
                                                .user.value.value!.user.role ==
                                            'General User'
                                    ? GroupInfo.groupListExtension.length
                                    : GroupInfo.groupList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: constraints.maxWidth < 768
                                      ? 2 / 2.0
                                      : 2 / 2.4,
                                  mainAxisSpacing:
                                      constraints.maxWidth < 768 ? 10 : 20,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return GroupsCard(
                                    groupInfo: userController.user.value.value!
                                                    .user.role ==
                                                'Extension Officer' ||
                                            userController.user.value.value!
                                                    .user.role ==
                                                'General User'
                                        ? GroupInfo.groupListExtension[index]
                                        : GroupInfo.groupList[index],
                                    constraints: constraints,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        // Ads section
                        Container(
                          height: constraints.maxWidth < 768 ? 200 : 550,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: FutureBuilder<Ads?>(
                            future: RemoteServices.getAds(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return ListView.builder(
                                    itemCount: 2,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey.shade100,
                                        highlightColor: Colors.grey.shade200,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    });
                              } else if (snapshot.hasData) {
                                return AdsWidget(
                                  ads: snapshot.data!.data,
                                );
                              } else {
                                return const Center(
                                  child: Text('No images available'),
                                );
                              }
                            },
                          ),
                        ),
                        // Featured Products section Header
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'home_featured_products'.tr,
                                style: TextStyle(
                                  fontSize:
                                      constraints.maxWidth < 768 ? 12 : 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness ==
                                          lightThemeData(context).brightness
                                      ? kContentColorLightTheme
                                      : kContentColorDarkTheme,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Featured Products section

                        // Obx(
                        //   () => productsController.loading.isFalse
                        //       ? ProductsGridShimmer(constraints: constraints)
                        //       : productsController.products.value.value == null
                        //           ? const EmptyWidget(text: 'No Products!')
                        //           : FadeInDown(
                        //               from: 30,
                        //               child: MasonryGridView.count(
                        //                 padding: const EdgeInsets.only(
                        //                     top: 15, bottom: 10),
                        //                 crossAxisCount:
                        //                     constraints.maxWidth < 768 ? 2 : 3,
                        //                 mainAxisSpacing: 15,
                        //                 crossAxisSpacing: 15,
                        //                 itemCount: productsController
                        //                     .products.value.value!.length,
                        //                 physics:
                        //                     const NeverScrollableScrollPhysics(),
                        //                 shrinkWrap: true,
                        //                 itemBuilder: (context, index) {
                        //                   return ProductCard(
                        //                     products: productsController
                        //                         .products.value.value![index],
                        //                     constraints: constraints,
                        //                     isDetailScreen: false,
                        //                   );
                        //                 },
                        //               ),
                        //             ),
                        // ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: FutureBuilder(
                            future: productsController.getProducts(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return ProductsGridShimmer(
                                    constraints: constraints);
                              } else if (snapshot.hasData) {
                                return FadeInDown(
                                  from: 30,
                                  child: Obx(
                                    () => MasonryGridView.count(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 10),
                                      crossAxisCount:
                                          constraints.maxWidth < 768 ? 2 : 3,
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 15,
                                      itemCount: productsController
                                          .products.value.value!.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ProductCard(
                                          products: productsController
                                              .products.value.value![index],
                                          constraints: constraints,
                                          isDetailScreen: false,
                                        );
                                      },
                                    ),
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: Text('No products'),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
