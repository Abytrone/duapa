import 'package:duapa/controllers/settings_controller.dart';
import 'package:duapa/models/language_model.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/constants.dart';
import '../../../services/theme.dart';
import 'widgets/lang_item.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  void initState() {
    getLanguageCode();
    super.initState();
  }

  // String? flag;
  String getCountryEmoji({required String countryCode}) {
    // String countryCode = 'us';
    String flag = countryCode.toUpperCase().replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) =>
              String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
        );

    return flag;
  }

  String? langCode;

  void getLanguageCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode');

    setState(() {
      langCode = languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'change_language'.tr),
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: GetBuilder<SettingsController>(
        init: SettingsController(),
        builder: (settingsController) {
          return ListView.builder(
            itemCount: LanguageModel.languagies.length,
            itemBuilder: (context, index) {
              return LangItem(
                onTap: () {
                  settingsController.changeLanguage(
                      languageCode:
                          LanguageModel.languagies[index].languageCode);
                  getLanguageCode();
                },
                countryEmoji: getCountryEmoji(
                    countryCode: LanguageModel.languagies[index].countryCode),
                text: LanguageModel.languagies[index].name,
                buttonColor: Colors.grey.shade300,
                textColor: Colors.grey.shade700,
                isSelected: langCode != null &&
                    LanguageModel.languagies[index].languageCode == langCode,
              );
            },
          );
        },
      ),
    );
  }
}
