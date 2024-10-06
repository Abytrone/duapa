import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:duapa/controllers/product_controller.dart';
import 'package:duapa/models/category_class.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/server.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/widgets/input_field.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/currency_class.dart';
import '../../../models/unit_of_mearsure_class.dart';
import '../../../services/product_services.dart';
import 'widgets/cover_image.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final ProductsController productsController = Get.find();

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();

  /// Set AnimationController to initState
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  String? token;
  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tokenStorage = localStorage.getString('token')!;
    setState(() {
      token = tokenStorage;
    });
  }

  final ProductServices productServices = ProductServices();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final bool _isLoading = false;
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  String category = '';
  String categoryID = '';
  String unitName = '';
  String unitId = '';
  String deliveryMode = 'Sea';
  String currencyCode = '';

  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Add Product',
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
            child: Obx(
              () => Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Visibility(
                      visible: productsController.isFilePicked.value == false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CoverImage(
                          text: 'Add product pictures',
                          onTap: () {
                            productsController.pickImages();
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: productsController.isFilePicked.value == true,
                      child: SizedBox(
                        height: 350,
                        child: ListView.builder(
                            itemCount: productsController.images.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: CoverImageSelected(
                                  file: productsController.images[index],
                                  onTap: () {
                                    productsController.pickImages();
                                  },
                                ),
                              );
                            }),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Dropdown search for categories
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 55,
                        width: constraints.maxWidth < 768 ? null : 500,
                        padding:
                            const EdgeInsets.only(left: 48, top: 0, bottom: 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(14)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: DropdownSearch<Category>(
                          validator: (value) {
                            if (value == null) {
                              return '* Required';
                            } else {
                              return null;
                            }
                          },
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              label: Text(
                                'Select Category',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: kContentColorLightTheme,
                                ),
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              isCollapsed: false,
                            ),
                          ),
                          dropdownButtonProps: DropdownButtonProps(
                            icon: Icon(
                              FontAwesomeIcons.angleDown,
                              color: Theme.of(context).brightness ==
                                      lightThemeData(context).brightness
                                  ? kContentColorLightTheme
                                  : kContentColorDarkTheme,
                            ),
                          ),
                          popupProps: PopupPropsMultiSelection.dialog(
                            errorBuilder: (BuildContext context, value, index) {
                              return const Center(
                                child: Text('No Data'),
                              );
                            },
                            searchFieldProps: const TextFieldProps(
                              decoration: InputDecoration(
                                label: Text(
                                  'Search...',
                                  style: TextStyle(
                                    color: kContentColorLightTheme,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                            dialogProps: const DialogProps(
                              backgroundColor: kContentColorDarkTheme,
                            ),
                            title: const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Text(
                                    'Select Category',
                                    style: TextStyle(
                                      color: kContentColorLightTheme,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            showSearchBox: true,
                          ),
                          onChanged: (data) {
                            setState(() {
                              category = data!.categoryName;
                              categoryID = data.id.toString();
                            });
                            // print(data);
                          },
                          asyncItems: (filter) async {
                            var response = await Dio().get(
                              categoryRoute,
                              options: Options(
                                headers: {
                                  'Accept': '*/*',
                                  'Content-Type': 'application/json',
                                  'Authorization': 'Bearer $token'
                                },
                              ),
                            );
                            var models = Category.fromJsonList(
                                response.data as List<dynamic>);
                            return models;
                          },
                        ),
                      ),
                    ),
                    //Dropdown search box for categories
                    const SizedBox(height: 10),

                    /// TextFromField Firstname
                    TextFromField(
                      label: "Name",
                      controller: title,
                      enabled: _isLoading ? false : true,
                      textCapitalization: TextCapitalization.words,
                      secured: false,
                      leftPadding: 0.0,
                      validate: (title) {
                        if (title == null || title.isEmpty) {
                          return "* Required";
                        } else if (title.length < 3) {
                          return "* Details should be at least 3 characters";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 55,
                        width: constraints.maxWidth < 768 ? null : 500,
                        padding:
                            const EdgeInsets.only(left: 48, top: 0, bottom: 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(14)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: DropdownSearch<CountryCurrency>(
                          validator: (value) {
                            if (value == null) {
                              return '* Required';
                            } else {
                              return null;
                            }
                          },
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              label: Text(
                                'Currency',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: kContentColorLightTheme,
                                ),
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              isCollapsed: false,
                            ),
                          ),
                          dropdownButtonProps: DropdownButtonProps(
                            icon: Icon(
                              FontAwesomeIcons.angleDown,
                              color: Theme.of(context).brightness ==
                                      lightThemeData(context).brightness
                                  ? kContentColorLightTheme
                                  : kContentColorDarkTheme,
                            ),
                          ),
                          popupProps: PopupPropsMultiSelection.dialog(
                            errorBuilder: (BuildContext context, value, index) {
                              return const Center(
                                child: Text('No Data'),
                              );
                            },
                            searchFieldProps: const TextFieldProps(
                              decoration: InputDecoration(
                                label: Text(
                                  'Search',
                                  style: TextStyle(
                                    color: kContentColorLightTheme,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                            ),
                            dialogProps: const DialogProps(
                              backgroundColor: kContentColorDarkTheme,
                            ),
                            title: const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Text(
                                    'Select Currency',
                                    style: TextStyle(
                                      color: kContentColorLightTheme,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            showSearchBox: true,
                          ),
                          onChanged: (data) {
                            setState(() {
                              currencyCode = data!.currencyCode;
                            });
                          },
                          asyncItems: (filter) async {
                            // Parse the JSON string
                            List<dynamic> jsonResponse = jsonDecode(jsonString);

                            var models =
                                CountryCurrency.fromJsonList(jsonResponse);
                            return models;
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFromFieldShort(
                          label: "Price",
                          width: constraints.maxWidth < 768 ? 190 : 240,
                          left: constraints.maxWidth < 768 ? 20 : 260,
                          right: 5,
                          controller: price,
                          enabled: _isLoading ? false : true,
                          textCapitalization: TextCapitalization.words,
                          inputType: TextInputType.phone,
                          secured: false,
                          leftPadding: 0.0,
                          validate: (price) {
                            if (price == null || price.isEmpty) {
                              return "* Required";
                            } else {
                              return null;
                            }
                          },
                        ),
                        TextFromFieldShort(
                          label: "Quantity",
                          width: constraints.maxWidth < 768 ? 190 : 240,
                          right: constraints.maxWidth < 768 ? 20 : 260,
                          left: 5,
                          controller: quantity,
                          enabled: _isLoading ? false : true,
                          textCapitalization: TextCapitalization.words,
                          inputType: TextInputType.phone,
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
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Dropdown search for categories
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 55,
                        width: constraints.maxWidth < 768 ? null : 500,
                        padding:
                            const EdgeInsets.only(left: 48, top: 0, bottom: 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(14)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: DropdownSearch<UnitofMearsure>(
                          validator: (value) {
                            if (value == null) {
                              return '* Required';
                            } else {
                              return null;
                            }
                          },
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              label: Text(
                                'Select Unit of Measure',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: kContentColorLightTheme,
                                ),
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              isCollapsed: false,
                            ),
                          ),
                          dropdownButtonProps: DropdownButtonProps(
                            icon: Icon(
                              FontAwesomeIcons.angleDown,
                              color: Theme.of(context).brightness ==
                                      lightThemeData(context).brightness
                                  ? kContentColorLightTheme
                                  : kContentColorDarkTheme,
                            ),
                          ),
                          popupProps: PopupPropsMultiSelection.dialog(
                            errorBuilder: (BuildContext context, value, index) {
                              return const Center(
                                child: Text('No Data'),
                              );
                            },
                            searchFieldProps: const TextFieldProps(
                              decoration: InputDecoration(
                                label: Text(
                                  'Search',
                                  style: TextStyle(
                                    color: kContentColorLightTheme,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                            ),
                            dialogProps: const DialogProps(
                              backgroundColor: kContentColorDarkTheme,
                            ),
                            title: const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Text(
                                    'Select Unit of Mearsure',
                                    style: TextStyle(
                                      color: kContentColorLightTheme,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            showSearchBox: true,
                          ),
                          onChanged: (data) {
                            setState(() {
                              unitName = data!.unitName;
                              unitId = data.id.toString();
                            });
                          },
                          asyncItems: (filter) async {
                            var response = await Dio().get(
                              '$protocol$baseUrl/api/v1/product/uom',
                              options: Options(
                                headers: {
                                  'Accept': '*/*',
                                  'Content-Type': 'application/json',
                                  'Authorization': 'Bearer $token'
                                },
                              ),
                            );
                            var models = UnitofMearsure.fromJsonList(
                                response.data as List<dynamic>);
                            return models;
                          },
                        ),
                      ),
                    ),
                    //Dropdown for Delivery Mode
                    const SizedBox(height: 20),

                    /// TextFromField Firstname
                    TextFromField(
                      inputType: TextInputType.multiline,
                      enabled: _isLoading ? false : true,
                      label: "Product Details",
                      controller: description,
                      leftPadding: 0.0,
                      textCapitalization: TextCapitalization.sentences,
                      secured: false,
                      validate: (description) {
                        if (description == null || description.isEmpty) {
                          return "* Required";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: PrimaryButton(
                        text: 'Save',
                        onPressed: () {
                          if (formKey!.currentState!.validate()) {
                            Map<String, String> body = {
                              'title': title.text,
                              'category': categoryID.toString(),
                              'description': description.text,
                              'price': price.text,
                              'quantity': quantity.text,
                              'delivery_mode': deliveryMode,
                              'uom': unitId.toString(),
                              'currency_code': currencyCode,
                            };
                            _asyncProceedDialog(context, body);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<ProceedAction?> _asyncProceedDialog(
      BuildContext context, Map<String, String> body) async {
    return showDialog<ProceedAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Alert',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kWarninngColor,
            ),
          ),
          content: const Text(
              'Please note that after submitting, you won\'t be able to edit your product again. \n\nIf you need to edit your product, you will have to contact the system administrator.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(ProceedAction.cancel);
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(kDarkLightColor),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: kDarkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(ProceedAction.accept);
                productServices.uploadProducts(
                  parameters: body,
                  imagePaths: productsController.imagePaths,
                );
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(kPrimaryColor),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

enum ProceedAction { cancel, accept }
