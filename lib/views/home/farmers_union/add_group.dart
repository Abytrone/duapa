import 'package:csc_picker/csc_picker.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/remote_services.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:duapa/views/widgets/input_field.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class AddCoporateGroup extends StatefulWidget {
  const AddCoporateGroup({super.key});

  @override
  State<AddCoporateGroup> createState() => _AddCoporateGroupState();
}

class _AddCoporateGroupState extends State<AddCoporateGroup> {
  final TextEditingController groupName = TextEditingController();
  final TextEditingController district = TextEditingController();
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  final RemoteServices _services = RemoteServices();
  String countryValue = "";
  String? stateValue = "";
  String? cityValue = "";

  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Create Coporate Group'),
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: Form(
            key: formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                  child: Text(
                    "Create coporate group",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: constraints.maxWidth < 768 ? 20 : 30,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Please fill the form below to create a\ncoporate group',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: constraints.maxWidth < 768 ? 12 : 20,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFromField(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Required";
                      } else {
                        return null;
                      }
                    },
                    enabled: _isLoading ? false : true,
                    icon: Icons.person_outline,
                    label: "Group Name",
                    secured: false,
                    textCapitalization: TextCapitalization.words,
                    controller: groupName,
                    leftPadding: 20.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),

                  // FORM LOCATION WIDGET
                  child: SizedBox(
                    width: constraints.maxWidth < 768 ? null : 550,
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
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFromField(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Required";
                      } else {
                        return null;
                      }
                    },
                    enabled: _isLoading ? false : true,
                    icon: Icons.location_city_outlined,
                    label: "District",
                    secured: false,
                    textCapitalization: TextCapitalization.words,
                    controller: district,
                    leftPadding: 20.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: PrimaryButton(
                    text: 'Submit',
                    onPressed: () {
                      Map<String, dynamic> body = {
                        "group_name": groupName.text,
                        "country": countryValue,
                        "region": stateValue,
                        "city": cityValue,
                        "district": district.text
                      };
                      groupName.clear();
                      district.clear();
                      _services.addGroup(body);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
