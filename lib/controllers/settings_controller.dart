import 'package:duapa/services/settings_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  final SettingsServices settingsServices = SettingsServices();

  void changeLanguage({required String languageCode}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
    switch (languageCode) {
      case 'en':
        Get.updateLocale(const Locale('en', 'US'));
        break;
      case 'fr':
        Get.updateLocale(const Locale('fr'));
        break;
      case 'de':
        Get.updateLocale(const Locale('de', 'DE'));
        break;
      default:
        Get.updateLocale(const Locale('en', 'US'));
    }
  }

  void changeCurrency({required String currencyCode}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currency_code', currencyCode);

    await settingsServices.changeCurrency(currencyCode: currencyCode);
  }
}
