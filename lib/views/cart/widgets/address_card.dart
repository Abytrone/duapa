import 'package:duapa/controllers/user_controller.dart';
import 'package:duapa/models/shipping_address_class.dart';
import 'package:duapa/views/cart/shipping_address/shipping_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../services/constants.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.constraints,
    required this.hasDefault,
    this.shippingAddressModel,
  });
  final BoxConstraints constraints;
  final String hasDefault;
  final ShippingAddressModel? shippingAddressModel;

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();
    return InkWell(
      onTap: () {
        Get.to(() => const ShippingAddressScreen(route: 1));
      },
      child: Container(
        width: constraints.maxWidth,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: constraints.maxWidth < 768 ? 15.0 : 20,
              color: Colors.grey.shade900.withOpacity(0.1),
              spreadRadius: 3.0,
              offset: const Offset(5, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Iconsax.location,
                  color: kPrimaryColor,
                ),
                const SizedBox(width: 10),
                Visibility(
                  visible: hasDefault == 'false',
                  child: const Text(
                    'Add a shipping address',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                shippingAddressModel == null
                    ? const SizedBox.shrink()
                    : Visibility(
                        visible: hasDefault == 'true',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible:
                                  userController.user.value.value!.user.role !=
                                      'Farmer',
                              child: Text(
                                shippingAddressModel!.email ??
                                    'noemail@email.com',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                                  userController.user.value.value!.user.role ==
                                      'Farmer',
                              child: Text(
                                shippingAddressModel!.phone,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                                  userController.user.value.value!.user.role !=
                                      'Farmer',
                              child: Text(
                                shippingAddressModel!.phone,
                                style: const TextStyle(
                                  color: Color(0xE8808080),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Text(
                              '${shippingAddressModel!.address}, ${shippingAddressModel!.city}',
                              style: const TextStyle(
                                color: Color(0xE8808080),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '${shippingAddressModel!.region}, ${shippingAddressModel!.country}',
                              style: const TextStyle(
                                color: Color(0xE8808080),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            ),
            const Icon(
              Iconsax.arrow_right_24,
              color: Color(0xE8808080),
            ),
          ],
        ),
      ),
    );
  }
}
