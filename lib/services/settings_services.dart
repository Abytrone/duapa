import 'package:duapa/services/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'server.dart';

class SettingsServices {
  Future<bool> changeCurrency({required String currencyCode}) async {
    try {
      final SharedPreferences localStorage =
          await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      final response = await http.post(
        Uri.parse('$protocol$baseUrl/api/v1/settings/update-currency'),
        body: {'preferred_currency': currencyCode},
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        AbySnackBar.successSnackbar(text: 'Currency updated successfully!');
        return true;
      } else {
        AbySnackBar.warningSnackbar(
            text:
                'Your request could not be completed, please try again later.');
        return false;
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Error occured, please try again later.');
      return false;
    }
  }

  // The converted price of a product, should be in the users prefered currency
}
