import 'package:badges/badges.dart' as badges;
import 'package:duapa/controllers/cart_controller.dart';
import 'package:duapa/controllers/user_controller.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/views/account/account.dart';
import 'package:duapa/views/cart/cart.dart';
import 'package:duapa/views/extention_officer/request_list.dart';
import 'package:duapa/views/home/home.dart';
import 'package:duapa/views/products/farmer_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upgrader/upgrader.dart';

import '../stores/stores.dart';

class BottomNavy extends StatefulWidget {
  const BottomNavy({super.key, this.page});
  final int? page;

  @override
  State<BottomNavy> createState() => _BottomNavyState();
}

class _BottomNavyState extends State<BottomNavy> {
  var currentIndex = 0;
  PageController? _pageController;
  final UserController userController = Get.find();
  final CartController cartController = Get.find();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.page ?? currentIndex);
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpgradeAlert(
        child: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = widget.page ?? index;
              });
            },
            children: userController.user.value.value!.user.role == 'Farmer' ||
                    userController.user.value.value!.user.role ==
                        'Service Provider'
                ? const [
                    HomeScreen(),
                    StoresScreen(),
                    FarmerProductScreen(),
                    CartScreen(),
                    AccountPage(),
                  ]
                : userController.user.value.value!.user.role ==
                        'Extension Officer'
                    ? const [
                        HomeScreen(),
                        StoresScreen(),
                        RequestListScreen(),
                        CartScreen(),
                        AccountPage(),
                      ]
                    : const [
                        HomeScreen(),
                        StoresScreen(),
                        CartScreen(),
                        AccountPage(),
                      ],
          ),
        ),
      ),
      extendBody: false,
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BottomNavigationBar(
            currentIndex: widget.page ?? currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
                _pageController!.jumpToPage(index);
              });
            },
            selectedItemColor: kPrimaryColor,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Get.size.width < 768 ? 12 : 20,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Get.size.width < 768 ? 12 : 20,
            ),
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: Icon(
                    Iconsax.home_2,
                    color: currentIndex == 0 || widget.page == 0
                        ? Theme.of(context).colorScheme.primary
                        : kLightGreyColor,
                    size: Get.size.width < 768 ? 20 : 25,
                  ),
                ),
                label: 'navy_home'.tr,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: Icon(
                    Iconsax.shop,
                    color: currentIndex == 1 || widget.page == 1
                        ? Theme.of(context).colorScheme.primary
                        : kLightGreyColor,
                    size: Get.size.width < 768 ? 20 : 25,
                  ),
                ),
                label: 'navy_stores'.tr,
              ),
              if (userController.user.value.value!.user.role ==
                  'Extension Officer')
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Icon(
                      Iconsax.activity,
                      color: currentIndex == 2 || widget.page == 2
                          ? Theme.of(context).colorScheme.primary
                          : kLightGreyColor,
                      size: Get.size.width < 768 ? 20 : 25,
                    ),
                  ),
                  label: 'navy_requests'.tr,
                ),
              if (userController.user.value.value!.user.role == 'Farmer' ||
                  userController.user.value.value!.user.role ==
                      'Service Provider')
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Icon(
                      Iconsax.box,
                      color: currentIndex == 2 || widget.page == 2
                          ? Theme.of(context).colorScheme.primary
                          : kLightGreyColor,
                      size: Get.size.width < 768 ? 20 : 25,
                    ),
                  ),
                  label: 'navy_products'.tr,
                ),
              userController.user.value.value!.user.role == 'Farmer' ||
                      userController.user.value.value!.user.role ==
                          'Service Provider' ||
                      userController.user.value.value!.user.role ==
                          'Extension Officer'
                  ? BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child: Icon(
                          Iconsax.shopping_cart,
                          color: currentIndex == 3 || widget.page == 3
                              ? Theme.of(context).colorScheme.primary
                              : kLightGreyColor,
                          size: Get.size.width < 768 ? 20 : 25,
                        ),
                      ),
                      label: 'navy_cart'.tr,
                    )
                  : BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child: Icon(
                          Iconsax.shopping_cart,
                          color: currentIndex == 2 || widget.page == 2
                              ? Theme.of(context).colorScheme.primary
                              : kLightGreyColor,
                          size: Get.size.width < 768 ? 20 : 25,
                        ),
                      ),
                      label: 'navy_cart'.tr,
                    ),
              userController.user.value.value!.user.role == 'Farmer' ||
                      userController.user.value.value!.user.role ==
                          'Service Provider' ||
                      userController.user.value.value!.user.role ==
                          'Extension Officer'
                  ? BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child: Icon(
                          Iconsax.profile_circle,
                          color: currentIndex == 4 || widget.page == 4
                              ? Theme.of(context).colorScheme.primary
                              : kLightGreyColor,
                          size: Get.size.width < 768 ? 20 : 25,
                        ),
                      ),
                      label: 'navy_account'.tr,
                    )
                  : BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child: Icon(
                          Iconsax.profile_circle,
                          color: currentIndex == 3 || widget.page == 3
                              ? Theme.of(context).colorScheme.primary
                              : kLightGreyColor,
                          size: Get.size.width < 768 ? 20 : 25,
                        ),
                      ),
                      label: 'navy_account'.tr,
                    ),
            ],
          ),
          Positioned(
            top: 2,
            right: userController.user.value.value!.user.role == 'Farmer' ||
                    userController.user.value.value!.user.role ==
                        'Service Provider' ||
                    userController.user.value.value!.user.role ==
                        'Extension Officer'
                ? currentIndex <= 2 || widget.page == 2
                    ? 100
                    : currentIndex == 4 || widget.page == 4
                        ? 140
                        : currentIndex == 3 || widget.page == 3
                            ? 120
                            : 100
                : currentIndex == 0 || widget.page == 0
                    ? 120
                    : currentIndex == 1 || widget.page == 1
                        ? 130
                        : currentIndex == 2 || widget.page == 2
                            ? 150
                            : currentIndex == 4 || widget.page == 4
                                ? 140
                                : currentIndex == 3 || widget.page == 3
                                    ? 170
                                    : 100,
            child: FutureBuilder(
              future: Future.delayed(Duration.zero),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -10, end: -12),
                    showBadge: true,
                    ignorePointer: false,
                    badgeContent: Obx(
                      () => Text(
                        cartController.cartCount.toString(),
                        style: const TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    badgeAnimation: const badges.BadgeAnimation.scale(
                      animationDuration: Duration(seconds: 1),
                      colorChangeAnimationDuration: Duration(seconds: 1),
                      loopAnimation: false,
                      curve: Curves.fastOutSlowIn,
                      colorChangeAnimationCurve: Curves.easeInCubic,
                    ),
                    badgeStyle: const badges.BadgeStyle(
                      shape: badges.BadgeShape.circle,
                      badgeColor: kErrorColor,
                      padding: EdgeInsets.all(5),
                      elevation: 0,
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
