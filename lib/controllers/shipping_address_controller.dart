import 'package:duapa/controllers/user_controller.dart';
import 'package:duapa/models/shipping_address_class.dart';
import 'package:duapa/services/shipping_address_services.dart';
import 'package:get/get.dart';

import '../views/cart/shipping_address/shipping_address.dart';

class ShippingAddressController extends GetxController {
  final ShippingAddressServices shippingAddressServices =
      ShippingAddressServices();
  final UserController userController = Get.find();
  Future<bool> addAddress({
    required String userid,
    required String phone,
    required String email,
    required String address,
    required String city,
    required String region,
    required String country,
  }) async {
    final response = await shippingAddressServices.addAddress(
      userid: userid,
      phone: phone,
      email: email,
      address: address,
      city: city,
      region: region,
      country: country,
    );

    if (response) {
      getUserAddresses(userid: userid);
      getDefaultAddress();
      Get.to(() => const ShippingAddressScreen(route: 3));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateAddress({
    required String addressId,
    required String phone,
    required String email,
    required String address,
    required String city,
    required String region,
    required String country,
  }) async {
    // Map<String, dynamic> data = {
    //   addressId: addressId,
    //   phone: phone,
    //   email: email,
    //   address: address,
    //   city: city,
    //   region: region,
    //   country: country,
    // };
    // print(data);
    // return false;
    final response = await shippingAddressServices.updateAddress(
      addressId: addressId,
      phone: phone,
      email: email,
      address: address,
      city: city,
      region: region,
      country: country,
    );

    if (response) {
      getUserAddresses(userid: userController.user.value.value!.user.id);
      getDefaultAddress();
      Get.to(() => const ShippingAddressScreen(route: 3));
      return true;
    } else {
      return false;
    }
  }

  var addresses = Rxn<List<ShippingAddressModel>?>().obs;
  var isLoading = true.obs;

  Future<bool> getUserAddresses({required String userid}) async {
    final response = await shippingAddressServices.getUserAddresses(
      userid: userid,
    );

    try {
      isLoading(true);
      if (addresses.value.value == null) {
        if (response != null) {
          addresses.value.value = response;
          return true;
        } else {
          return false;
        }
      } else {
        addresses.value.value!.clear();
        if (response != null) {
          addresses.value.value = response;
          return true;
        } else {
          return false;
        }
      }
    } finally {
      isLoading(false);
    }
  }

  var defaultAddress = Rxn<ShippingAddressModel>().obs;
  Future<bool> getDefaultAddress() async {
    final result = await shippingAddressServices.getUserDefaultAddresses();
    if (result != null) {
      defaultAddress.value.value = result;
      getUserAddresses(userid: userController.user.value.value!.user.id);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> makeDefault({required String id}) async {
    final result = await shippingAddressServices.makeAddressDefault(
      id: id,
    );
    if (result == true) {
      getUserAddresses(userid: userController.user.value.value!.user.id);
      getDefaultAddress();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteAddress({required String id}) async {
    final response = await shippingAddressServices.deleteAddress(id: id);
    if (response == true) {
      getUserAddresses(userid: userController.user.value.value!.user.id);
      return true;
    } else {
      return false;
    }
  }
}
