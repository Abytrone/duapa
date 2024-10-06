import 'package:duapa/services/server.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/service_providers_stores.dart';

class StoreServices {
  Future<ServiceProvidersStores> getStores() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Uri url = Uri.parse('https://$baseUrl/api/v1/service-provider/list');
    final response = await http.get(
      url,
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return serviceProvidersStoresFromJson(response.body);
  }
}
