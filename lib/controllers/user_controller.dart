import 'package:duapa/models/user_class.dart';
import 'package:duapa/services/auth_services.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final AuthServices authServices = AuthServices();
  var isLoading = true.obs;
  var user = Rxn<User>().obs;

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  Future<AuthData> getUser() async {
    try {
      isLoading(true);
      final response = await authServices.getAuthUser();
      if (response.user != null) {
        user.value(response.user);
        // print(response.user);
        // print('Response from controller: ${response.user.profilePicture!}');
        return AuthData(other: null, user: response.user);
      } else if (response.other != null) {
        return AuthData(other: response.other, user: null);
      } else {
        isLoading(false);
        return AuthData(other: null, user: null);
      }
    } finally {
      isLoading(false);
    }
  }
}
