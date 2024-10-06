import 'dart:convert';

import 'package:duapa/controllers/settings_controller.dart';
import 'package:duapa/models/currency_class.dart';
import 'package:duapa/views/account/settings/widgets/lang_item.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  String? currencyCode;

  void getCurrencyCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? currCode = prefs.getString('currency_code');

    setState(() {
      currencyCode = currCode;
    });
  }

  @override
  void initState() {
    getCurrencyCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> jsonResponse = jsonDecode(jsonString);

    var countries = CountryCurrency.fromJsonList(jsonResponse);
    return Scaffold(
      appBar: appBar(context: context, title: 'Change Currency'),
      body: GetBuilder<SettingsController>(
          init: SettingsController(),
          builder: (settingsController) {
            return ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                return LangItem(
                  onTap: () {
                    settingsController.changeCurrency(
                        currencyCode: countries[index].currencyCode);
                    getCurrencyCode();
                  },
                  countryEmoji: countries[index].flagUnicode,
                  text:
                      '${countries[index].countryName} - ${countries[index].currencyCode}',
                  buttonColor: Colors.grey.shade300,
                  textColor: Colors.grey.shade700,
                  isSelected: currencyCode != null &&
                      countries[index].currencyCode == currencyCode,
                );
              },
            );
          }),
    );
  }
}
