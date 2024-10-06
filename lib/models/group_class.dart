import 'package:duapa/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupInfo {
  GroupInfo({
    required this.ikon,
    required this.title,
    required this.route,
  });

  final String ikon;
  final Text title;
  final String route;

  static List<GroupInfo> groupList = <GroupInfo>[
    GroupInfo(
      ikon: 'assets/icon/manager.png',
      // title: 'group_extension',
      title: Text(
        'group_extension'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Get.mediaQuery.size.width < 768 ? 12 : 20,
          fontWeight: FontWeight.w500,
          color: kContentColorLightTheme,
        ),
      ),
      route: 'govenmentofficers',
    ),
    GroupInfo(
      ikon: 'assets/icon/tree.png',
      // title: 'group_microcredit',
      title: Text(
        'group_microcredit'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Get.mediaQuery.size.width < 768 ? 12 : 20,
          fontWeight: FontWeight.w500,
          color: kContentColorLightTheme,
        ),
      ),
      route: 'bottomnavy',
    ),
    GroupInfo(
      ikon: 'assets/icon/teamwork.png',
      // title: 'group_farmers',
      title: Text(
        'group_farmers'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Get.mediaQuery.size.width < 768 ? 12 : 20,
          fontWeight: FontWeight.w500,
          color: kContentColorLightTheme,
        ),
      ),
      route: 'allcoporategroups',
    ),
    // GroupInfo(
    //   ikon: 'assets/icon/aggregation.png',
    //   title: 'Aggregators\n ',
    //   route: 'bottomnavy',
    // ),
    GroupInfo(
      ikon: 'assets/icon/megaphone.png',
      // title: 'group_marketing',
      title: Text(
        'group_marketing'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Get.mediaQuery.size.width < 768 ? 12 : 20,
          fontWeight: FontWeight.w500,
          color: kContentColorLightTheme,
        ),
      ),
      route: 'bottomnavy',
    ),
    GroupInfo(
      ikon: 'assets/icon/rain.png',
      // title: 'group_weather',
      title: Text(
        'group_weather'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Get.mediaQuery.size.width < 768 ? 12 : 20,
          fontWeight: FontWeight.w500,
          color: kContentColorLightTheme,
        ),
      ),
      route: 'bottomnavy',
    ),
    GroupInfo(
      ikon: 'assets/icon/delivery-truck.png',
      // title: 'group_transport',
      title: Text(
        'group_transport'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Get.mediaQuery.size.width < 768 ? 12 : 20,
          fontWeight: FontWeight.w500,
          color: kContentColorLightTheme,
        ),
      ),
      route: 'alldrivers',
    ),
    GroupInfo(
      ikon: 'assets/icon/blogging.png',
      // title: 'group_blog',
      title: Text(
        'group_blog'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Get.mediaQuery.size.width < 768 ? 12 : 20,
          fontWeight: FontWeight.w500,
          color: kContentColorLightTheme,
        ),
      ),
      route: 'blog',
    ),
    GroupInfo(
      ikon: 'assets/icon/clipboard.png',
      // title: 'group_insurance',
      title: Text(
        'group_insurance'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Get.mediaQuery.size.width < 768 ? 12 : 20,
          fontWeight: FontWeight.w500,
          color: kContentColorLightTheme,
        ),
      ),
      route: 'bottomnavy',
    ),
  ];

  static List<GroupInfo> groupListExtension = <GroupInfo>[
    GroupInfo(
      ikon: 'assets/icon/tree.png',
      // title: 'group_microcredit',
      title: Text(
        'group_microcredit'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Get.mediaQuery.size.width < 768 ? 12 : 20,
          fontWeight: FontWeight.w500,
          color: kContentColorLightTheme,
        ),
      ),
      route: 'bottomnavy',
    ),
    GroupInfo(
      ikon: 'assets/icon/teamwork.png',
      // title: 'group_farmers',
      title: Text(
        'group_farmers'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Get.mediaQuery.size.width < 768 ? 12 : 20,
          fontWeight: FontWeight.w500,
          color: kContentColorLightTheme,
        ),
      ),
      route: 'allcoporategroups',
    ),
    // GroupInfo(
    //   ikon: 'assets/icon/aggregation.png',
    //   title: 'Aggregators\n ',
    //   route: 'bottomnavy',
    // ),
    GroupInfo(
      ikon: 'assets/icon/megaphone.png',
      // title: 'group_marketing',
      title: Text(
        'group_marketing'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Get.mediaQuery.size.width < 768 ? 12 : 20,
          fontWeight: FontWeight.w500,
          color: kContentColorLightTheme,
        ),
      ),
      route: 'bottomnavy',
    ),
    GroupInfo(
      ikon: 'assets/icon/rain.png',
      // title: 'group_weather',
      title: Text(
        'group_weather'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Get.mediaQuery.size.width < 768 ? 12 : 20,
          fontWeight: FontWeight.w500,
          color: kContentColorLightTheme,
        ),
      ),
      route: 'bottomnavy',
    ),
    GroupInfo(
      ikon: 'assets/icon/delivery-truck.png',
      // title: 'group_transport',
      title: Text(
        'group_transport'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Get.mediaQuery.size.width < 768 ? 12 : 20,
          fontWeight: FontWeight.w500,
          color: kContentColorLightTheme,
        ),
      ),
      route: 'alldrivers',
    ),
    GroupInfo(
      ikon: 'assets/icon/blogging.png',
      // title: 'group_blog',
      title: Text(
        'group_blog'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Get.mediaQuery.size.width < 768 ? 12 : 20,
          fontWeight: FontWeight.w500,
          color: kContentColorLightTheme,
        ),
      ),
      route: 'blog',
    ),
    GroupInfo(
      ikon: 'assets/icon/clipboard.png',
      // title: 'group_insurance',
      title: Text(
        'group_insurance'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Get.mediaQuery.size.width < 768 ? 12 : 20,
          fontWeight: FontWeight.w500,
          color: kContentColorLightTheme,
        ),
      ),
      route: 'bottomnavy',
    ),
  ];
}
