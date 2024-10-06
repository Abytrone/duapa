import 'package:csc_picker/csc_picker.dart';
import 'package:duapa/controllers/shipping_address_controller.dart';
import 'package:duapa/controllers/user_controller.dart';
import 'package:duapa/views/cart/shipping_address/shipping_address.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../services/constants.dart';
import '../../../services/theme.dart';
import '../../widgets/input_field.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({super.key});

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final ShippingAddressController shippingAddressController = Get.find();
  final UserController userController = Get.find();
  static GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  final PhoneNumber phoneNumber = PhoneNumber(isoCode: 'GH');
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
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.off(() => const ShippingAddressScreen(route: 1));
            },
            icon: const Icon(Icons.chevron_left),
          ),
          title: LayoutBuilder(builder: (context, constraints) {
            return Text(
              'Add Address',
              style: TextStyle(
                fontSize: constraints.maxWidth < 768 ? 12 : 17,
                color: Theme.of(context).brightness ==
                        lightThemeData(context).brightness
                    ? kContentColorLightTheme
                    : kContentColorDarkTheme,
              ),
            );
          }),
          centerTitle: true,
          backgroundColor:
              Theme.of(context).brightness == lightThemeData(context).brightness
                  ? kContentColorDarkTheme
                  : kContentColorLightTheme,
          iconTheme: IconThemeData(
            color: Theme.of(context).brightness ==
                    lightThemeData(context).brightness
                ? kContentColorLightTheme
                : kContentColorDarkTheme,
          ),
        ),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Required";
                      } else {
                        return null;
                      }
                    },
                    textStyle: const TextStyle(
                      color: kContentColorLightTheme,
                    ),
                    selectorTextStyle: const TextStyle(
                      color: kContentColorLightTheme,
                    ),
                    inputDecoration: const InputDecoration(
                      border: InputBorder.none,
                      labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black38,
                        fontWeight: FontWeight.w600,
                      ),
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
                    label: "Email",
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
                      } else if (email.isEmpty) {
                        return "* Required";
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
                  label: "Address",
                  controller: address,
                  enabled: isLoading ? false : true,
                  textCapitalization: TextCapitalization.words,
                  secured: false,
                  leftPadding: 0.0,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return "* Required";
                    } else {
                      return null;
                    }
                  },
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
                  text: 'Save',
                  onPressed: () {
                    if (formKey!.currentState!.validate()) {
                      formKey!.currentState!.save();
                      shippingAddressController.addAddress(
                        userid: userController.user.value.value!.user.id,
                        phone: phone!,
                        email: email.text,
                        address: address.text,
                        city: cityValue!,
                        region: stateValue!,
                        country: countryValue,
                      );
                      formKey!.currentState!.reset();
                    }
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
