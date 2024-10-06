import 'package:duapa/services/password_reset_services.dart';
import 'package:get/get.dart';

class PasswordResetController extends GetxController {
  final PasswordResetServices passwordResetServices = PasswordResetServices();

  var isLoading = true.obs;
}
