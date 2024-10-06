import 'package:cached_network_image/cached_network_image.dart';
import 'package:duapa/controllers/user_controller.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/account/about_screen.dart';
import 'package:duapa/views/account/chat_ai.dart';
import 'package:duapa/views/account/farm/farms.dart';
import 'package:duapa/views/account/orders/orders.dart';
import 'package:duapa/views/account/product/add_product_form.dart';
import 'package:duapa/views/account/product/sold_products.dart';
import 'package:duapa/views/account/settings/settings.dart';
import 'package:duapa/views/account/support/support_tickets.dart';
import 'package:duapa/views/account/update_profile.dart';
import 'package:duapa/views/widgets/empty.dart';
import 'package:duapa/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

import 'attributes.dart';
import 'gallery.dart';
import 'widgets/account_item.dart';
import 'widgets/logout_dialog.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final UserController _userController = Get.find();
  final LogoutDialogBox logoutDialogBox = LogoutDialogBox();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const ChatAIScreen());
        },
        backgroundColor: Colors.white,
        child: Image.asset(
          'assets/icon/chat.png',
          width: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Obx(
              () => _userController.isLoading.isTrue
                  ? const AbyLoading()
                  : _userController.user.value.value != null
                      ? Stack(
                          children: <Widget>[
                            // Setting Header Banner
                            SizedBox(
                              width: double.infinity,
                              height: constraints.maxWidth < 768 ? 240.0 : 400,
                              child: FadeInImage.assetNetwork(
                                placeholder:
                                    'assets/img/placeholder_landscape.png',
                                image:
                                    'https://img.freepik.com/free-photo/healthy-vegetables-wooden-table_1150-38006.jpg?w=2000&t=st=1695776623~exp=1695777223~hmac=ae876586d6e71ed8761230b18319aa016f569945170143dd6bef1a14b2fce36e',
                                fit: BoxFit.cover,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Center(
                                    child: Image.asset(
                                      'assets/img/placeholder_landscape.png',
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      constraints.maxWidth < 768 ? 185.0 : 300),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Obx(() {
                                        return CachedNetworkImage(
                                          imageUrl: _userController
                                                      .user
                                                      .value
                                                      .value
                                                      ?.user
                                                      .profilePicture ==
                                                  null
                                              ? 'https://cdn-icons-png.flaticon.com/512/3135/3135768.png'
                                              : _userController
                                                          .user
                                                          .value
                                                          .value
                                                          ?.user
                                                          .profilePicture ==
                                                      'https://con.duapa.online/storage'
                                                  ? 'https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png'
                                                  : '${_userController.user.value.value?.user.profilePicture}',
                                          imageBuilder:
                                              (context, imageProvider) {
                                            return Container(
                                              height: constraints.maxWidth < 768
                                                  ? 100.0
                                                  : 200,
                                              width: constraints.maxWidth < 768
                                                  ? 100.0
                                                  : 200,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width:
                                                        constraints.maxWidth <
                                                                768
                                                            ? 2.5
                                                            : 4),
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                                color: Colors.white,
                                              ),
                                            );
                                          },
                                          placeholder: (context, url) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey.shade50,
                                              highlightColor:
                                                  Colors.grey.shade200,
                                              child: Container(
                                                height:
                                                    constraints.maxWidth < 768
                                                        ? 100.0
                                                        : 200,
                                                width:
                                                    constraints.maxWidth < 768
                                                        ? 100.0
                                                        : 200,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2.5),
                                                  shape: BoxShape.circle,
                                                  // image: const DecorationImage(
                                                  //   image: AssetImage(
                                                  //       'assets/img/broken-image.png'),
                                                  //   fit: BoxFit.cover,
                                                  // ),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                          },
                                          errorWidget: (context, url, error) {
                                            return Container(
                                              height: constraints.maxWidth < 768
                                                  ? 100.0
                                                  : 200,
                                              width: constraints.maxWidth < 768
                                                  ? 100.0
                                                  : 200,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 2.5),
                                                shape: BoxShape.circle,
                                                image: const DecorationImage(
                                                  image: NetworkImage(
                                                      'https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                                color: Colors.white,
                                              ),
                                            );
                                          },
                                        );
                                      }),
                                      Visibility(
                                        visible: _userController.user.value
                                                    .value!.user.role ==
                                                'Farmer'
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            _userController.user.value.value!
                                                            .user.firstName !=
                                                        'N/A' &&
                                                    _userController
                                                            .user
                                                            .value
                                                            .value!
                                                            .user
                                                            .surname !=
                                                        'N/A'
                                                ? '${_userController.user.value.value!.user.firstName} ${_userController.user.value.value!.user.surname}'
                                                : '${_userController.user.value.value!.user.role}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize:
                                                  constraints.maxWidth < 768
                                                      ? 17
                                                      : 25,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      lightThemeData(context)
                                                          .brightness
                                                  ? kContentColorLightTheme
                                                  : kContentColorDarkTheme,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: _userController.user.value
                                                    .value!.user.role ==
                                                'Service Provider'
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            '${_userController.user.value.value!.user.companyName}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize:
                                                  constraints.maxWidth < 768
                                                      ? 17
                                                      : 25,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      lightThemeData(context)
                                                          .brightness
                                                  ? kContentColorLightTheme
                                                  : kContentColorDarkTheme,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: _userController.user.value
                                                    .value!.user.role ==
                                                'General User'
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            _userController.user.value.value!
                                                        .user.firstName ==
                                                    'N/A'
                                                ? '${_userController.user.value.value!.user.role}'
                                                : '${_userController.user.value.value!.user.firstName} ${_userController.user.value.value!.user.surname}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize:
                                                  constraints.maxWidth < 768
                                                      ? 17
                                                      : 25,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      lightThemeData(context)
                                                          .brightness
                                                  ? kContentColorLightTheme
                                                  : kContentColorDarkTheme,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: _userController.user.value
                                                    .value!.user.role ==
                                                'Extension Officer'
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            _userController.user.value.value!
                                                        .user.firstName ==
                                                    'N/A'
                                                ? '${_userController.user.value.value!.user.role}'
                                                : '${_userController.user.value.value!.user.firstName} ${_userController.user.value.value!.user.surname}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize:
                                                  constraints.maxWidth < 768
                                                      ? 17
                                                      : 25,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      lightThemeData(context)
                                                          .brightness
                                                  ? kContentColorLightTheme
                                                  : kContentColorDarkTheme,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: (_userController.user.value
                                                    .value!.user.role ==
                                                'Service Provider')
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 0.0),
                                          child: Text(
                                            _userController.user.value.value!
                                                        .user.email ==
                                                    null
                                                ? ''
                                                : '- ${_userController.user.value.value!.user.email!} -',
                                            style: TextStyle(
                                              fontSize:
                                                  constraints.maxWidth < 768
                                                      ? 13
                                                      : 20,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      lightThemeData(context)
                                                          .brightness
                                                  ? kContentColorLightTheme
                                                  : kContentColorDarkTheme,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: _userController.user.value
                                                    .value!.user.role !=
                                                'Service Provider'
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 0.0),
                                          child: Text(
                                            '- @${_userController.user.value.value!.user.username} -',
                                            style: TextStyle(
                                              fontSize:
                                                  constraints.maxWidth < 768
                                                      ? 13
                                                      : 20,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      lightThemeData(context)
                                                          .brightness
                                                  ? kContentColorLightTheme
                                                  : kContentColorDarkTheme,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      constraints.maxWidth < 768 ? 360.0 : 560),
                              child: Column(
                                children: <Widget>[
                                  Visibility(
                                    visible: (_userController.user.value.value!
                                                    .user.role ==
                                                'Service Provider' ||
                                            _userController.user.value.value!
                                                    .user.role ==
                                                'Farmer')
                                        ? true
                                        : false,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _userController
                                                        .user
                                                        .value
                                                        .value!
                                                        .preferredCurrency,
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      color: kGreyColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    _userController
                                                        .user
                                                        .value
                                                        .value!
                                                        .user
                                                        .totalAmountSold
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Text(
                                                'Paid Revenue',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: kGreyColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                              height: 50,
                                              width: 1,
                                              color:
                                                  kDarkColor.withOpacity(0.2)),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _userController
                                                        .user
                                                        .value
                                                        .value!
                                                        .preferredCurrency,
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      color: kGreyColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    _userController
                                                        .user
                                                        .value
                                                        .value!
                                                        .user
                                                        .totalAmountPending
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Text(
                                                'Pending Revenue',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: kGreyColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  AccountItem(
                                    txt: "My Orders",
                                    icon: Iconsax.shop_add,
                                    color: kPrimaryColor,
                                    tap: () {
                                      Get.to(() => const OrdersScreen(
                                            tabIndex: 0,
                                            isCheckout: false,
                                          ));
                                    },
                                  ),
                                  if (_userController
                                              .user.value.value!.user.role ==
                                          'Farmer' ||
                                      _userController
                                              .user.value.value!.user.role ==
                                          'Service Provider')
                                    AccountItem(
                                      txt: "Sold Products",
                                      icon: Iconsax
                                          .box, // "assets/icon/sold.png", // <a href="https://www.flaticon.com/free-icons/sold-out" title="sold out icons">Sold out icons created by pojok d - Flaticon</a>
                                      color: kPrimaryColor,
                                      tap: () {
                                        Get.to(() => const SoldProducts());
                                      },
                                    ),
                                  if (_userController
                                          .user.value.value!.user.role ==
                                      'Farmer')
                                    AccountItem(
                                      txt: "My Farms",
                                      icon: Iconsax
                                          .crop, // "assets/icon/farm.png",
                                      color: kPrimaryColor,
                                      tap: () {
                                        Get.to(() => const FarmsScreen());
                                      },
                                    ),
                                  if (_userController
                                              .user.value.value!.user.role ==
                                          'Farmer' ||
                                      _userController
                                              .user.value.value!.user.role ==
                                          'Service Provider')
                                    AccountItem(
                                      txt: "Add Product",
                                      icon: Iconsax
                                          .additem, // "assets/icon/add.png",
                                      color: kPrimaryColor,
                                      tap: () {
                                        Get.to(() => const AddProduct());
                                      },
                                    ),
                                  AccountItem(
                                    txt: "Edit Profile",
                                    icon: Iconsax
                                        .profile_tick, // "assets/icon/edit_profile.png",
                                    color: kPrimaryColor,
                                    tap: () {
                                      Get.to(() => UpdateProfile(
                                            user: _userController
                                                .user.value.value!,
                                          ));
                                    },
                                  ),
                                  AccountItem(
                                    txt: "Gallery",
                                    icon: Iconsax
                                        .gallery, // "assets/icon/gallery.png",
                                    color: kPrimaryColor,
                                    tap: () {
                                      Get.to(() => const GalleryHome());
                                    },
                                  ),
                                  AccountItem(
                                    txt: "Support Center",
                                    icon: Iconsax
                                        .call_outgoing, // "assets/icon/callcenter.png",
                                    color: kPrimaryColor,
                                    tap: () {
                                      Get.to(
                                          () => const SupportTicketsScreen());
                                    },
                                  ),
                                  AccountItem(
                                    txt: "About App",
                                    icon: Iconsax
                                        .archive, // "assets/icon/info.png",
                                    color: kPrimaryColor,
                                    tap: () {
                                      Get.to(() => const AboutApp());
                                    },
                                  ),
                                  AccountItem(
                                    txt: "Attributes",
                                    icon: Iconsax.attach_circle,
                                    color: kPrimaryColor,
                                    tap: () {
                                      Get.to(() => const AttributesScreen());
                                    },
                                  ),
                                  AccountItem(
                                    txt: "Settings",
                                    icon: Iconsax
                                        .setting, // "assets/icon/setting.png",
                                    color: kPrimaryColor,
                                    tap: () {
                                      Get.to(() => const SettingScreen());
                                    },
                                  ),
                                  AccountItem(
                                    txt: "Log Out",
                                    icon: Iconsax
                                        .logout, // "assets/icon/logout.png",
                                    color: kErrorColor,
                                    tap: () {
                                      logoutDialogBox.asyncConfirmDialog(
                                        context: context,
                                      );
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 55.0, right: 13.0),
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
                                ],
                              ),
                            ),
                          ],
                        )
                      : const EmptyWidget(text: 'User data empty.'),
            );
          },
        ),
      ),
    );
  }
}
