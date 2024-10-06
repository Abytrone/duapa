import 'package:csc_picker/csc_picker.dart';
import 'package:duapa/controllers/shipping_address_controller.dart';
import 'package:duapa/controllers/user_controller.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../models/shipping_address_class.dart';
import '../../../services/constants.dart';
import '../../../services/theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/input_field.dart';

class AddressEditForm extends StatefulWidget {
  const AddressEditForm({
    super.key,
    required this.shippingAddressModel,
  });
  final ShippingAddressModel shippingAddressModel;

  @override
  State<AddressEditForm> createState() => _AddressEditFormState();
}

class _AddressEditFormState extends State<AddressEditForm> {
  final ShippingAddressController shippingAddressController = Get.find();
  final UserController userController = Get.find();
  static GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();
  String? phone;
  String? isoCode;
  String countryValue = "";
  String? stateValue = "";
  String? cityValue = "";

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final PhoneNumber phoneNumber = PhoneNumber(isoCode: 'GH');
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: appBar(context: context, title: 'Edit Address'),
        backgroundColor:
            Theme.of(context).brightness == lightThemeData(context).brightness
                ? kContentColorDarkTheme
                : kContentColorLightTheme,
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: Container(
                  height: 53,
                  width: constraints.maxWidth < 768 ? 450 : 500,
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(blurRadius: 10.0, color: Colors.black12)
                      ]),
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 30.0,
                  ),
                  child: InternationalPhoneNumberInput(
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.DIALOG,
                      trailingSpace: false,
                    ),
                    formatInput: true,
                    initialValue: phoneNumber,
                    textStyle: const TextStyle(
                      color: kContentColorLightTheme,
                    ),
                    selectorTextStyle: const TextStyle(
                      color: kContentColorLightTheme,
                    ),
                    inputDecoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Phone Number',
                      labelText: widget.shippingAddressModel.phone,
                    ),
                    keyboardType: TextInputType.phone,
                    onInputChanged: (PhoneNumber value) {
                      phone = value.phoneNumber;
                      isoCode = value.isoCode;
                    },
                  ),
                ),
              ),
              Visibility(
                visible: userController.user.value.value!.user.role != 'Farmer',
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFromField(
                    label: widget.shippingAddressModel.email,
                    hintText: 'Email',
                    controller: email,
                    enabled: isLoading ? false : true,
                    textCapitalization: TextCapitalization.none,
                    inputType: TextInputType.emailAddress,
                    secured: false,
                    leftPadding: 0.0,
                    validate: (email) {
                      String pattern =
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?)*$";
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(email!)) {
                        return 'Enter a valid email address';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFromField(
                  label: widget.shippingAddressModel.address,
                  hintText: 'Address',
                  controller: address,
                  enabled: isLoading ? false : true,
                  textCapitalization: TextCapitalization.words,
                  secured: false,
                  leftPadding: 0.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),

                // FORM LOCATION WIDGET
                child: SizedBox(
                  width: constraints.maxWidth < 768 ? 500 : 550,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 29.0, right: 29.0),
                    child: Column(
                      children: [
                        CSCPicker(
                          // key: _cscPickerKey,
                          showStates: true,
                          showCities: true,
                          flagState: CountryFlag.ENABLE,

                          cityDropdownLabel: widget.shippingAddressModel.city,
                          stateDropdownLabel:
                              widget.shippingAddressModel.region,
                          countryDropdownLabel:
                              widget.shippingAddressModel.country,

                          ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.0),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 10.0,
                                color: Colors.black12,
                              ),
                            ],
                          ),

                          ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                          disabledDropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.0),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 10.0,
                                color: Colors.black12,
                              ),
                            ],
                          ),

                          ///selected item style [OPTIONAL PARAMETER]
                          selectedItemStyle: const TextStyle(
                            color: kContentColorLightTheme,
                            fontSize: 12,
                          ),

                          ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                          dropdownHeadingStyle: TextStyle(
                            color: Theme.of(context).brightness ==
                                    lightThemeData(context).brightness
                                ? kContentColorLightTheme
                                : kContentColorDarkTheme,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),

                          ///DropdownDialog Item style [OPTIONAL PARAMETER]
                          dropdownItemStyle: TextStyle(
                            color: Theme.of(context).brightness ==
                                    lightThemeData(context).brightness
                                ? kContentColorLightTheme
                                : kContentColorDarkTheme,
                            fontSize: 12,
                          ),

                          ///Dialog box radius [OPTIONAL PARAMETER]
                          dropdownDialogRadius: 10.0,

                          ///Search bar radius [OPTIONAL PARAMETER]
                          searchBarRadius: 10.0,

                          ///triggers once country selected in dropdown
                          onCountryChanged: (value) {
                            setState(() {
                              ///store value in country variable
                              countryValue = value;
                            });
                          },

                          ///triggers once state selected in dropdown
                          onStateChanged: (value) {
                            setState(() {
                              ///store value in state variable
                              stateValue = value;
                            });
                          },

                          ///triggers once city selected in dropdown
                          onCityChanged: (value) {
                            setState(() {
                              ///store value in city variable
                              cityValue = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PrimaryButton(
                  text: 'Update',
                  onPressed: () {
                    // if (formKey!.currentState!.validate()) {
                    shippingAddressController.updateAddress(
                      addressId: widget.shippingAddressModel.id.toString(),
                      phone: phone == null
                          ? widget.shippingAddressModel.phone
                          : phone!,
                      email: email.text == ''
                          ? widget.shippingAddressModel.email ?? ''
                          : email.text,
                      address: address.text == ''
                          ? widget.shippingAddressModel.address
                          : address.text,
                      city: cityValue == ''
                          ? widget.shippingAddressModel.city
                          : cityValue!,
                      region: stateValue == ''
                          ? widget.shippingAddressModel.region
                          : stateValue!,
                      country: countryValue == ''
                          ? widget.shippingAddressModel.country
                          : countryValue,
                    );
                    formKey!.currentState!.reset();
                    // }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
