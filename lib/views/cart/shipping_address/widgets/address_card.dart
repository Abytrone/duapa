import 'package:duapa/controllers/shipping_address_controller.dart';
import 'package:duapa/views/cart/shipping_address/widgets/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../models/shipping_address_class.dart';
import '../../../../models/user_class.dart';
import '../../../../services/constants.dart';
import '../address_edit.dart';

class AddressCard extends StatefulWidget {
  const AddressCard({
    super.key,
    required this.constraints,
    required this.shippingAddressModel,
    required this.userClass,
  });
  final BoxConstraints constraints;
  final ShippingAddressModel shippingAddressModel;
  final UserClass userClass;

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    final DeleteDialog deleteDialog = DeleteDialog();
    final ShippingAddressController shippingAddressController = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: InkWell(
        onTap: () {
          if (widget.shippingAddressModel.isDefault != 1) {
            shippingAddressController.makeDefault(
              id: widget.shippingAddressModel.id.toString(),
            );
          }
        },
        child: Container(
          width: widget.constraints.maxWidth,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: widget.constraints.maxWidth < 768 ? 15.0 : 20,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   widget.userClass.username!,
                      //   style: const TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     color: kPrimaryColor,
                      //   ),
                      // ),
                      Text(
                        widget.shippingAddressModel.phone,
                        style: const TextStyle(
                          color: Color(0xE8808080),
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${widget.shippingAddressModel.address}, ${widget.shippingAddressModel.city}',
                        style: const TextStyle(
                          color: Color(0xE8808080),
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${widget.shippingAddressModel.region}, ${widget.shippingAddressModel.country}',
                        style: const TextStyle(
                          color: Color(0xE8808080),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PopupMenuButton<String>(
                    position: PopupMenuPosition.under,
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      widget.shippingAddressModel.isDefault == 1
                          ? const PopupMenuItem<String>(
                              value: '',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.radio_button_checked,
                                    size: 15,
                                    color: kPrimaryColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Alread Default',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const PopupMenuItem<String>(
                              value: 'Default',
                              child: Row(
                                children: [
                                  Icon(Icons.radio_button_unchecked, size: 15),
                                  SizedBox(width: 10),
                                  Text(
                                    'Make Default',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                      const PopupMenuItem<String>(
                        value: 'Edit',
                        child: Row(
                          children: [
                            Icon(Iconsax.edit, size: 15),
                            SizedBox(width: 10),
                            Text(
                              'Edit',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Delete',
                        child: Row(
                          children: [
                            Icon(Iconsax.trash, color: kErrorColor, size: 15),
                            SizedBox(width: 10),
                            Text(
                              'Delete',
                              style: TextStyle(
                                color: kErrorColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (String value) {
                      if (value == 'Edit') {
                        Get.to(() => AddressEditForm(
                              shippingAddressModel: widget.shippingAddressModel,
                            ));
                      } else if (value == 'Delete') {
                        deleteDialog.asyncConfirmDialog(
                          context: context,
                          id: widget.shippingAddressModel.id.toString(),
                        );
                      } else if (value == 'Default') {
                        shippingAddressController.makeDefault(
                          id: widget.shippingAddressModel.id.toString(),
                        );
                      }
                    },
                    icon: const Icon(Icons.more_vert),
                  ),
                  Radio(
                    value: widget.shippingAddressModel.isDefault == 1,
                    groupValue: true,
                    onChanged: (bool? value) {
                      if (value != null) {
                        // Toggle the selection status of the current item
                        if (value != true) {
                          shippingAddressController.makeDefault(
                            id: widget.shippingAddressModel.id.toString(),
                          );
                        }
                      }
                    },
                    activeColor: kPrimaryColor,
                  ),

                  // shippingAddressModel.isDefault == 1
                  //     ? const Icon(
                  //         Icons.radio_button_checked,
                  //         color: kPrimaryColor,
                  //       )
                  //     : IconButton(
                  //         onPressed: () {
                  //           shippingAddressController.makeDefault(
                  //             id: shippingAddressModel.id.toString(),
                  //           );
                  //         },
                  //         icon: const Icon(Icons.radio_button_unchecked),
                  //       ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
