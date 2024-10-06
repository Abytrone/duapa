import 'package:duapa/services/country_services.dart';
import 'package:get/get.dart';

class CountryController extends GetxController {
  final CountryServices countryServices = CountryServices();
  var country = Rxn<dynamic>().obs;
  Future<bool> getCountry() async {
    final response = await countryServices.getCountry();

    if (response != null) {
      country.value.value = response;
      return true;
    } else {
      return false;
    }
  }

  @override
  void onInit() {
    getCountry();
    super.onInit();
  }
}
