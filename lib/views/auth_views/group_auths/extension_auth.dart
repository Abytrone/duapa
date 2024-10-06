import 'dart:io';

import 'package:duapa/services/auth_services.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/widgets/input_field.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loading_indicator/loading_indicator.dart';

class GovernmentOfficer extends StatefulWidget {
  @override
  State<GovernmentOfficer> createState() => _GovernmentOfficerState();
  const GovernmentOfficer({super.key, this.title});
  final String? title;
}

class _GovernmentOfficerState extends State<GovernmentOfficer> {
  final AuthServices authServices = AuthServices();
  // FORM CONTROLLERS
  final TextEditingController fullName = TextEditingController();
  // final TextEditingController surname = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  String? sex;
  final PhoneNumber phoneNumber = PhoneNumber(isoCode: 'GH');
  final TextEditingController services = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  String? phone;
  String? isoCode;
  // String countryValue = "";
  // String? stateValue = "";
  // String? cityValue = "";

  bool ssecured = true;
  bool psecured = true;
  bool isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();

  File? _file;
  PlatformFile? _platformFile;

  selectFile() async {
    try {
      final file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (file != null) {
        setState(() {
          _file = File(file.files.single.path!);
          _platformFile = file.files.first;
        });
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: "Error picking file, please try again");
    }
  }

  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.size.height;
    mediaQueryData.size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).brightness == lightThemeData(context).brightness
                ? kContentColorDarkTheme
                : kContentColorLightTheme,
        iconTheme: IconThemeData(
          color:
              Theme.of(context).brightness == lightThemeData(context).brightness
                  ? kContentColorLightTheme
                  : kContentColorDarkTheme,
        ),
      ),
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                /// padding logo
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                          width: 1,
                        ),
                        image: const DecorationImage(
                          image: AssetImage('assets/app_icon/icon.png'),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                  child: Text(
                    "Signup as a Extension Officer",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
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
                    'Please fill the form below to signup\nas a Extension Officer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),

                /// TextFromField Firstname
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
                    enabled: isLoading ? false : true,
                    icon: Icons.person_outline,
                    label: "Full Name",
                    secured: false,
                    textCapitalization: TextCapitalization.words,
                    controller: fullName,
                    leftPadding: 20.0,
                  ),
                ),

                /// TextFromField Surname
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
                    enabled: isLoading ? false : true,
                    icon: Icons.person_outline,
                    label: "Username",
                    secured: false,
                    textCapitalization: TextCapitalization.none,
                    controller: username,
                    leftPadding: 20.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Container(
                    height: 53,
                    width: mediaQueryData.size.width > 600 ? 450 : null,
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),

                  /// TextFromField Email
                  child: TextFromField(
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
                    enabled: isLoading ? false : true,
                    icon: Icons.email_outlined,
                    label: "Email",
                    secured: false,
                    textCapitalization: TextCapitalization.none,
                    controller: email,
                    inputType: TextInputType.emailAddress,
                    leftPadding: 20.0,
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
                    enabled: isLoading ? false : true,
                    icon: Icons.cases_outlined,
                    label: "Services",
                    secured: false,
                    textCapitalization: TextCapitalization.sentences,
                    inputType: TextInputType.multiline,
                    controller: services,
                    leftPadding: 20.0,
                  ),
                ),

                InkWell(
                  onTap: () {
                    selectFile();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Container(
                      height: 53,
                      width: mediaQueryData.size.width > 600 ? 450 : null,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(blurRadius: 10.0, color: Colors.black12)
                          ]),
                      padding: const EdgeInsets.only(left: 30.0, right: 20.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.document_scanner_outlined,
                            color: Colors.black38,
                          ),
                          const SizedBox(width: 15),
                          const Text(
                            'Certificate:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: kContentColorLightTheme,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            _platformFile == null
                                ? 'Select file'
                                : _platformFile!.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              color: kContentColorLightTheme,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// TextFromField Password
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFromField(
                    validate: (password) {
                      if (password == null || password.isEmpty) {
                        return "* Required";
                      } else if (password.length < 6) {
                        return "Password should be at least 6 characters";
                      } else if (password.length > 15) {
                        return "Password should not be greater than 15 characters";
                      } else {
                        return null;
                      }
                    },
                    enabled: isLoading ? false : true,
                    icon: Icons.lock_outline_rounded,
                    sufIcon: IconButton(
                        icon: Icon(psecured
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        color: Colors.grey,
                        onPressed: () {
                          setState(() {
                            psecured = !psecured;
                          });
                        }),
                    label: "Password",
                    secured: psecured,
                    textCapitalization: TextCapitalization.none,
                    inputType: TextInputType.text,
                    controller: password,
                    maxLines: 1,
                    leftPadding: 20.0,
                  ),
                ),

                /// TextFromField Password
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFromField(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Required";
                      } else if (value != password.text) {
                        return "Please this should match with your password";
                      } else {
                        return null;
                      }
                    },
                    enabled: isLoading ? false : true,
                    icon: Icons.lock_outline_rounded,
                    sufIcon: IconButton(
                        icon: Icon(ssecured
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        color: Colors.grey,
                        onPressed: () {
                          setState(() {
                            ssecured = !ssecured;
                          });
                        }),
                    label: "Confirm Password",
                    secured: ssecured,
                    textCapitalization: TextCapitalization.none,
                    inputType: TextInputType.text,
                    controller: confirmpassword,
                    maxLines: 1,
                    leftPadding: 20.0,
                  ),
                ),

                const SizedBox(height: 30),

                isLoading
                    ? const Padding(
                        padding: EdgeInsets.only(
                          left: 160.0,
                          right: 160,
                        ),
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballBeat,
                        ),
                      )
                    : PrimaryButton(
                        text: 'Signup',
                        onPressed: () {
                          if (formKey!.currentState!.validate()) {
                            // final String body =
                            //     'username=${username.text}&fullname=${fullName.text}&phone_number=$phone&services=${services.text}&role=2&password=${password.text}&password_confirmation=${confirmpassword.text}';

                            Map<String, String> body = {
                              'fullname': fullName.text,
                              'username': username.text,
                              'role': '2',
                              'phone_number': phone!,
                              'email': email.text,
                              'services': services.text,
                              'password': password.text,
                              'password_confirmation': confirmpassword.text,
                            };

                            if (_file != null) {
                              authServices.otpSend(
                                phoneNumber: phone!,
                                isoCode: isoCode!,
                                filepath: _file!.path,
                                username: username.text,
                                email: email.text,
                                mapBody: body,
                                userType: 'Extention Officer',
                              );
                            } else {
                              AbySnackBar.warningSnackbar(
                                  text: 'Please select your certificate.');
                            }
                          }
                        },
                      ),
                const SizedBox(height: 40),

                /// Button Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Have an Account?",
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).brightness ==
                                lightThemeData(context).brightness
                            ? kContentColorLightTheme
                            : kContentColorDarkTheme,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('login');
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: kErrorColor,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
