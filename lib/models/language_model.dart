class LanguageModel {
  String name;
  String countryCode;
  String languageCode;

  LanguageModel({
    required this.name,
    required this.countryCode,
    required this.languageCode,
  });

  static List<LanguageModel> languagies = <LanguageModel>[
    LanguageModel(
      name: 'English',
      countryCode: 'US',
      languageCode: 'en',
    ),
    LanguageModel(
      name: 'French',
      countryCode: 'FR',
      languageCode: 'fr',
    ),
    LanguageModel(
      name: 'German',
      countryCode: 'DE',
      languageCode: 'de',
    ),
  ];
}
