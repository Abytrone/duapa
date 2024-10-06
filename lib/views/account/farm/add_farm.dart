import 'dart:io';

import 'package:duapa/services/constants.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/account/farm/pick_farm_location.dart';
import 'package:duapa/views/widgets/input_field.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../product/widgets/cover_image.dart';

class AddFarm extends StatefulWidget {
  const AddFarm({super.key});

  @override
  State<AddFarm> createState() => _AddFarmState();
}

class _AddFarmState extends State<AddFarm> {
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  String token = '';
  Future<void> _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tokenStorage = localStorage.getString('token')!;
    setState(() {
      token = tokenStorage;
    });
  }

  File? _file;
  PlatformFile? _platformFile;

  selectFile() async {
    try {
      final file = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (file != null) {
        setState(() {
          _file = File(file.files.single.path!);
          _platformFile = file.files.first;
        });
      }
    } catch (e) {
      // print(e);
      AbySnackBar.errorSnackbar(text: '$e');
    }
  }

  static GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  final TextEditingController numberofAcres = TextEditingController();
  final TextEditingController numberofAcresProduced = TextEditingController();
  final TextEditingController productGrown = TextEditingController();
  final TextEditingController farmLocation = TextEditingController();
  final TextEditingController description = TextEditingController();
  final bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Farm',
            style: TextStyle(
              fontSize: constraints.maxWidth < 768 ? 12 : 17,
              color: Theme.of(context).brightness ==
                      lightThemeData(context).brightness
                  ? kContentColorLightTheme
                  : kContentColorDarkTheme,
            ),
          ),
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
        body: Container(
          color:
              Theme.of(context).brightness == lightThemeData(context).brightness
                  ? kContentColorDarkTheme
                  : kContentColorLightTheme,
          padding: const EdgeInsets.only(top: 10.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: _platformFile == null ? true : false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CoverImage(
                        text: 'Add farm picture',
                        onTap: () {
                          selectFile();
                        },
                      ),
                    ),
                  ),
                  _file == null
                      ? const SizedBox.shrink()
                      : Visibility(
                          visible: _platformFile != null ? true : false,
                          child: SizedBox(
                            height: 350,
                            child: CoverImageSelected(
                              file: _file!,
                              onTap: () {
                                selectFile();
                              },
                            ),
                          ),
                        ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                  // TextFromField Farm worth
                  TextFromField(
                    label: "Number of acres",
                    controller: numberofAcres,
                    enabled: _isLoading ? false : true,
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
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                  // TextFromField Farm worth
                  TextFromField(
                    label: "Number of acres produced",
                    controller: numberofAcresProduced,
                    enabled: _isLoading ? false : true,
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
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                  TextFromField(
                    label: "Product Grown",
                    controller: productGrown,
                    enabled: _isLoading ? false : true,
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
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                  TextFromField(
                    label: "Farm location",
                    controller: farmLocation,
                    enabled: _isLoading ? false : true,
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
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                  TextFromField(
                    label: "Description",
                    controller: description,
                    enabled: _isLoading ? false : true,
                    inputType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
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

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: PrimaryButton(
                      text: 'Next',
                      onPressed: () {
                        if (formKey!.currentState!.validate()) {
                          Map<String, String> body = {
                            'number_of_acres': numberofAcres.text,
                            'number_of_acres_produced':
                                numberofAcresProduced.text,
                            'product_grown': productGrown.text,
                            'farm_location': farmLocation.text,
                            'description': description.text,
                          };
                          Get.to(
                            () => PickFarmLocationScreen(
                              body: body,
                              farmImage: _file!.path,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
