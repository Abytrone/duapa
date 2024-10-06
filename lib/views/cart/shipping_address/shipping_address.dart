import 'package:duapa/controllers/shipping_address_controller.dart';
import 'package:duapa/controllers/user_controller.dart';
import 'package:duapa/views/cart/shipping_address/address_form.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/constants.dart';
import '../../../services/theme.dart';
import '../../widgets/app_bar.dart';
import 'widgets/address_card.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key, required this.route});
  final int route;

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final ShippingAddressController shippingAddressController = Get.find();
  final UserController userController = Get.find();
  @override
  void initState() {
    shippingAddressController.getUserAddresses(
        userid: userController.user.value.value!.user.id);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context: context,
        title: 'Addresses',
        leading: IconButton(
          onPressed: () {
            Get.close(widget.route);
          },
          icon: const Icon(CupertinoIcons.chevron_back),
        ),
      ),
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            Expanded(
              child: Obx(
                () => shippingAddressController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : shippingAddressController.addresses.value.value == null ||
                            shippingAddressController
                                .addresses.value.value!.isEmpty
                        ? const Center(child: Text('Empty'))
                        : RefreshIndicator(
                            onRefresh: () {
                              return shippingAddressController.getUserAddresses(
                                  userid:
                                      userController.user.value.value!.user.id);
                            },
                            child: ListView.builder(
                              itemCount: shippingAddressController
                                  .addresses.value.value!.length,
                              itemBuilder: (context, index) {
                                return AddressCard(
                                  constraints: constraints,
                                  shippingAddressModel:
                                      shippingAddressController
                                          .addresses.value.value![index],
                                  userClass:
                                      userController.user.value.value!.user,
                                );
                              },
                            ),
                          ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              alignment: Alignment.bottomCenter,
              child: PrimaryButton(
                text: 'Add New Address',
                onPressed: () {
                  Get.to(() => const AddressForm());
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
