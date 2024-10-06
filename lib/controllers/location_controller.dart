import 'package:get/get.dart';

class LocationController extends GetxController {
  var location = false.obs;

  // Future<bool> isUserInGhana() async {
  //   try {
  //     showDialog(
  //       context: Get.context!,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return const LoadingDialog();
  //       },
  //     );
  //     bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!isLocationEnabled) {
  //       Navigator.of(Get.overlayContext!).pop();
  //       return false;
  //     }

  //     LocationPermission permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         Navigator.of(Get.overlayContext!).pop();
  //         return false;
  //       }
  //     }

  //     if (permission == LocationPermission.deniedForever) {
  //       Navigator.of(Get.overlayContext!).pop();
  //       return false;
  //     }

  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     double latitude = position.latitude;
  //     double longitude = position.longitude;

  //     // print(latitude);
  //     // print(longitude);
  //     // print(permission);

  //     // Check if the user's location is in Ghana
  //     if (latitude >= 4.5 &&
  //         latitude <= 11.1 &&
  //         longitude >= -3.2 &&
  //         longitude <= 1.2) {
  //       Navigator.of(Get.overlayContext!).pop();
  //       location.value = true;
  //       return true;
  //     } else {
  //       Navigator.of(Get.overlayContext!).pop();
  //       return false;
  //     }
  //   } catch (e) {
  //     // print(e);
  //     return false;
  //   }
  // }
}

// print('Permission: $permission');
//         double latitude = position.latitude;
//         double longitude = position.longitude;

//         print(latitude);
//         print(longitude);

//         // Check if the user's location is in Ghana
//         if (latitude >= 4.5 &&
//             latitude <= 11.1 &&
//             longitude >= -3.2 &&
//             longitude <= 1.2) {
//           location.value = 'momo';
//         } else {
//           location.value = 'card';
//         }
