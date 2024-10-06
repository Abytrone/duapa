import 'package:csc_picker/csc_picker.dart';
import 'package:duapa/controllers/country_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../models/user_class.dart';
import '../../../services/constants.dart';
import '../../../services/profile_services.dart';
import '../../../services/theme.dart';
import '../../widgets/input_field.dart';

class UserInfoForm extends StatefulWidget {
  const UserInfoForm({super.key, this.user, required this.constraints});
  final User? user;
  final BoxConstraints constraints;

  @override
  State<UserInfoForm> createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  final bool _isEnabled = true;
  final GlobalKey<FormState>? userKey = GlobalKey<FormState>();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController middleName = TextEditingController();
  final TextEditingController surname = TextEditingController();
  String? gender;
  // ------------Service Provider--------------
  final TextEditingController companyName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController services = TextEditingController();

  final CountryController countryController = Get.find();

  String? phone;
  final ProfileServices profileServices = ProfileServices();

  String? countryValue = "";
  String? stateValue = "";
  String? cityValue = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: userKey,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'User Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),

          /// TextFromField FirstName
          Visibility(
            visible: widget.user!.user.role == 'Farmer' ||
                widget.user!.user.role == 'General User',
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: TextFromField(
                icon: Icons.person_outline,
                enabled: _isEnabled,
                label: "${widget.user!.user.firstName}",
                hintText: 'First Name',
                secured: false,
                textCapitalization: TextCapitalization.words,
                inputType: TextInputType.text,
                controller: firstName,
                maxLines: 1,
                leftPadding: 20.0,
              ),
            ),
          ),

          /// TextFromField Surname
          Visibility(
            visible: widget.user!.user.role == 'Farmer' ||
                widget.user!.user.role == 'General User',
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: TextFromField(
                icon: Icons.people_outline,
                enabled: _isEnabled,
                label: "${widget.user!.user.surname}",
                hintText: 'Surname',
                secured: false,
                textCapitalization: TextCapitalization.words,
                inputType: TextInputType.text,
                controller: surname,
                maxLines: 1,
                leftPadding: 20.0,
              ),
            ),
          ),

          Visibility(
            visible: widget.user!.user.role == 'Service Provider',
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: TextFromField(
                icon: Icons.person_outline,
                enabled: _isEnabled,
                label: "${widget.user!.user.companyName}",
                hintText: 'Company Name',
                secured: false,
                textCapitalization: TextCapitalization.words,
                inputType: TextInputType.text,
                controller: companyName,
                maxLines: 1,
                leftPadding: 20.0,
              ),
            ),
          ),
          Visibility(
            visible: widget.user!.user.role == 'Service Provider',
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: TextFromField(
                icon: Icons.person_outline,
                enabled: _isEnabled,
                label: "${widget.user!.user.email}",
                hintText: 'Email',
                secured: false,
                textCapitalization: TextCapitalization.none,
                inputType: TextInputType.text,
                controller: email,
                maxLines: 1,
                leftPadding: 20.0,
              ),
            ),
          ),
          Visibility(
            visible: widget.user!.user.role == 'Service Provider',
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: TextFromField(
                icon: Icons.person_outline,
                enabled: _isEnabled,
                label: "${widget.user!.user.username}",
                hintText: 'Username',
                secured: false,
                textCapitalization: TextCapitalization.none,
                inputType: TextInputType.text,
                controller: username,
                maxLines: 1,
                leftPadding: 20.0,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Container(
              height: 53,
              width: MediaQuery.of(context).size.width > 600 ? 450 : null,
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(blurRadius: 10.0, color: Colors.black12)
                  ]),
              padding: const EdgeInsets.only(left: 20.0, right: 30.0),
              child: InternationalPhoneNumberInput(
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.DIALOG,
                  trailingSpace: false,
                ),
                formatInput: true,
                initialValue: PhoneNumber(
                  isoCode: countryController.country.value.value['countryCode'],
                  phoneNumber: '${widget.user!.user.phoneNumber}',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return null;
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
                inputDecoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: '${widget.user!.user.phoneNumber}',
                  hintText: 'Phone Number',
                  labelStyle: const TextStyle(fontSize: 14.0),
                ),
                keyboardType: TextInputType.phone,
                onInputChanged: (PhoneNumber value) {
                  phone = value.phoneNumber;
                },
              ),
            ),
          ),

          Visibility(
            visible: widget.user!.user.role == 'Farmer' ||
                widget.user!.user.role == 'General User',
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 55,
                width: widget.constraints.maxWidth < 768 ? null : 500,
                padding: const EdgeInsets.only(left: 48),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField(
                        items: <String>['Male', 'Female']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        iconSize: 0,
                        decoration: InputDecoration(
                          label: Text(
                            widget.user!.user.sex ?? 'Select Gender',
                            style: const TextStyle(
                              fontSize: 15,
                              color: kContentColorLightTheme,
                            ),
                          ),
                          hintText: widget.user!.user.sex ?? '',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            // print(data);
                            gender = value!;
                          });
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 13),
                        child: Icon(
                          FontAwesomeIcons.angleDown,
                          color: Theme.of(context).brightness ==
                                  lightThemeData(context).brightness
                              ? kContentColorLightTheme
                              : kContentColorDarkTheme,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),

            // FORM LOCATION WIDGET
            child: SizedBox(
              width: MediaQuery.of(context).size.width > 600 ? 500 : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CSCPicker(
                      // key: _cscPickerKey,
                      showStates: true,
                      showCities: true,
                      flagState: CountryFlag.ENABLE,
                      currentCountry: widget.user!.user.country == 'N/A'
                          ? '   Select country'
                          : widget.user!.user.country,
                      currentCity: widget.user!.user.city == 'N/A'
                          ? 'City'
                          : widget.user!.user.city,
                      currentState: widget.user!.user.state == 'N/A'
                          ? 'State'
                          : widget.user!.user.state,
                      countryDropdownLabel: widget.user!.user.country == 'N/A'
                          ? 'Country'
                          : 'Country - ${widget.user!.user.country}',
                      stateDropdownLabel: widget.user!.user.state == 'N/A'
                          ? 'State'
                          : 'State - ${widget.user!.user.state}',
                      cityDropdownLabel: widget.user!.user.city == 'N/A'
                          ? 'City'
                          : 'City - ${widget.user!.user.city}',

                      ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(blurRadius: 10.0, color: Colors.black12),
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

          /// TextFromField Services
          Visibility(
            visible: widget.user!.user.role == 'Farmer' ||
                widget.user!.user.role == 'Service Provider',
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: TextFromField(
                icon: Icons.cases_outlined,
                enabled: _isEnabled,
                label: '${widget.user!.user.services}',
                hintText: 'Services',
                secured: false,
                textCapitalization: TextCapitalization.sentences,
                inputType: TextInputType.text,
                controller: services,
                maxLines: 1,
                leftPadding: 20.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    if (userKey!.currentState!.validate()) {
                      Map<String, dynamic> body = {
                        'first_name': firstName.text != ''
                            ? firstName.text
                            : widget.user!.user.firstName,
                        'surname': surname.text != ''
                            ? surname.text
                            : widget.user!.user.surname,
                        'sex': gender ?? widget.user!.user.sex,
                        'username': username.text != ''
                            ? username.text
                            : widget.user!.user.username,
                        'phone_number': phone != null
                            ? phone!.isNotEmpty
                                ? phone
                                : widget.user!.user.phoneNumber
                            : widget.user!.user.phoneNumber,
                        'country': countryValue ?? widget.user!.user.country,
                        'region': stateValue ?? widget.user!.user.region,
                        'city': cityValue ?? widget.user!.user.city,
                        'services': services.text != ''
                            ? services.text
                            : widget.user!.user.services,
                      };

                      Map<String, dynamic> serviceProvider = {
                        'company_name': companyName.text != ''
                            ? companyName.text
                            : widget.user!.user.companyName,
                        'email': email.text != ''
                            ? email.text
                            : widget.user!.user.email,
                        'username': username.text != ''
                            ? username.text
                            : widget.user!.user.username,
                        'phone_number': phone != null
                            ? phone!.isNotEmpty
                                ? phone
                                : widget.user!.user.phoneNumber
                            : widget.user!.user.phoneNumber,
                        'country': countryValue ?? widget.user!.user.country,
                        'region': stateValue ?? widget.user!.user.state,
                        'city': cityValue ?? widget.user!.user.city,
                        'services': services.text != ''
                            ? services.text
                            : widget.user!.user.services,
                      };

                      Map<String, dynamic> generalUser = {
                        'first_name': firstName.text != ''
                            ? firstName.text
                            : widget.user!.user.firstName,
                        'surname': surname.text != ''
                            ? surname.text
                            : widget.user!.user.surname,
                        'username': username.text != ''
                            ? username.text
                            : widget.user!.user.username,
                        'phone_number': phone != null
                            ? phone!.isNotEmpty
                                ? phone
                                : widget.user!.user.phoneNumber
                            : widget.user!.user.phoneNumber,
                        'sex': gender ?? widget.user!.user.sex,
                        'country': countryValue ?? widget.user!.user.country,
                        'region': stateValue ?? widget.user!.user.state,
                        'city': cityValue ?? widget.user!.user.city,
                      };

                      // print(serviceProvider);

                      if (widget.user!.user.role == 'Farmer') {
                        profileServices.updateProfile(body: body);
                      } else if (widget.user!.user.role == 'Service Provider') {
                        profileServices.updateProfile(body: serviceProvider);
                      } else if (widget.user!.user.role == 'General User') {
                        profileServices.updateProfile(body: generalUser);
                      }
                      // userKey!.currentState!.dispose();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // width: 80,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Center(
                        child: Text(
                          'Update Profile',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
