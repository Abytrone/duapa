String jsonString = '''
  [
    {
      "country_name": "Ghana",
      "currency_code": "GHS",
      "flag_unicode": "\\ud83c\\uddec\\ud83c\\udded"
    },
    {
      "country_name": "USA",
      "currency_code": "USD",
      "flag_unicode": "\\ud83c\\uddfa\\ud83c\\uddf8"
    }
  ]
  ''';

class CountryCurrency {
  final String countryName;
  final String currencyCode;
  final String flagUnicode;

  CountryCurrency({
    required this.countryName,
    required this.currencyCode,
    required this.flagUnicode,
  });

  // Factory constructor to create an instance from a map
  factory CountryCurrency.fromJson(Map<String, dynamic> json) {
    return CountryCurrency(
      countryName: json['country_name'],
      currencyCode: json['currency_code'],
      flagUnicode: json['flag_unicode'],
    );
  }

  static List<CountryCurrency> fromJsonList(List list) {
    return list.map((item) => CountryCurrency.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return currencyCode;
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(CountryCurrency model) {
    return currencyCode == model.currencyCode;
  }

  @override
  String toString() => '$flagUnicode $countryName-$currencyCode';
}
