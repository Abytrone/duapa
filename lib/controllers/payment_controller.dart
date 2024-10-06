import 'package:duapa/controllers/orders_controller.dart';
import 'package:duapa/services/payment_services.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final PaymentServices paymentServices = PaymentServices();
  final OrdersController ordersController = Get.find();
  var networkProvider = 'MTN'.obs;
  var phoneNumber = ''.obs;
  var paymentMethod = 'Card'.obs;

  void changePayment({required String value}) {
    paymentMethod.value = value;
  }

  Future<bool> payment({
    required String txRef,
    required String orderId,
    required String amount,
    required String currencyCode,
  }) async {
    final result = await paymentServices.verifyPayment(txRef: txRef);

    if (result != null) {
      if (result.data != null &&
          result.status == 'success' &&
          result.message == 'Transaction fetched successfully') {
        // print('Update duapa here');

        await paymentServices.updateDuapaPayment(
          orderId: orderId,
          total: result.data!.amount.toString(),
          transactionId: result.data!.id.toString(),
          txRef: txRef,
          flwRef: result.data!.flwRef,
          status: 'Paid',
        );
        ordersController.getUserOrderDetail(orderid: orderId);
      } else if (result.data == null) {
        // print('Make payment here');

        final payment = await paymentServices.makePayment(
          txRef: txRef,
          amount: amount,
          currencyCode: currencyCode,
          orderId: orderId,
        );
        if (payment) {
          final result = await paymentServices.verifyPayment(txRef: txRef);
          if (result != null &&
              result.data != null &&
              result.status == 'success' &&
              result.message == 'Transaction fetched successfully') {
            // print('Update duapa here');

            await paymentServices.updateDuapaPayment(
              orderId: orderId,
              total: result.data!.amount.toString(),
              transactionId: result.data!.id.toString(),
              txRef: txRef,
              flwRef: result.data!.flwRef,
              status: 'Paid',
            );
            ordersController.getUserOrderDetail(orderid: orderId);
          }
          // ordersController.getUserOrderDetail(orderid: orderId);
        }
      }
      return true;
    } else {
      return false;
    }
  }

  var country = ''.obs;
  Future<bool> getCountry() async {
    final response = await paymentServices.getCountry();

    if (response != null) {
      country.value = response;
      // print(response);
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
