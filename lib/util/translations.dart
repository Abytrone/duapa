import 'package:duapa/util/languages/de.dart';
import 'package:duapa/util/languages/en.dart';
import 'package:duapa/util/languages/fr.dart';
import 'package:get/get.dart';

class MyTranslations extends Translations {
  final EnglishTranslations englishTranslations = EnglishTranslations();
  final FrenchTranslations frenchTranslations = FrenchTranslations();
  final GermanTranslations germanTranslations = GermanTranslations();

  @override
  Map<String, Map<String, String>> get keys => {
        'en': englishTranslations.en,
        'fr': frenchTranslations.fr,
        'de': germanTranslations.de,
      };
}
