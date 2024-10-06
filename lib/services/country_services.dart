import 'dart:convert';

import 'package:http/http.dart' as http;

class CountryServices {
  Future<dynamic> getCountry() async {
    try {
      final response = await http.get(
        Uri.parse("http://ip-api.com/json"),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        final location = jsonDecode(response.body);
        if (location['status'] == 'success') {
          return location;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

// {
//   "status": "success",
//   "country": "Ghana",
//   "countryCode": "GH",
//   "region": "AA",
//   "regionName": "Greater Accra Region",
//   "city": "Accra",
//   "zip": "",
//   "lat": 5.5486,
//   "lon": -0.2012,
//   "timezone": "Africa/Accra",
//   "isp": "Scancom Ltd.",
//   "org": "Scancom Limited",
//   "as": "AS30986 Scancom Limited",
//   "query": "154.160.25.14"
// }
}
