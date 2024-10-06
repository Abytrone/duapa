import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/support_ticket_services.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/support_topic_class.dart';
import '../../widgets/input_field.dart';
import '../../widgets/primary_button.dart';

class SupportCenter extends StatefulWidget {
  const SupportCenter({super.key});

  @override
  State<SupportCenter> createState() => _SupportCenterState();
}

class _SupportCenterState extends State<SupportCenter> {
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

  final bool _isLoading = false;
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  // final TextEditingController topic = TextEditingController();
  String? topic;
  final TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: appBar(context: context, title: 'Request Support'),
        backgroundColor:
            Theme.of(context).brightness == lightThemeData(context).brightness
                ? kContentColorDarkTheme
                : kContentColorLightTheme,
        body: Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: Alignment.center,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Image(
                  height: 100,
                  width: 100,
                  image: AssetImage('assets/icon/call-center-agent.png'),
                ),
                const SizedBox(height: 20),
                Text(
                  'Need help about any of our\nservices or the app?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: constraints.maxWidth < 768 ? 12 : 17,
                    color: Theme.of(context).brightness ==
                            lightThemeData(context).brightness
                        ? kContentColorLightTheme
                        : kContentColorDarkTheme,
                  ),
                ),
                const SizedBox(height: 30),
                // Dropdown search for categories
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0, left: 30, right: 30, bottom: 5),
                  child: Container(
                    height: 55,
                    width: constraints.maxWidth < 768 ? null : 500,
                    padding: const EdgeInsets.only(left: 48, top: 0, bottom: 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(14)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: DropdownSearch<SupportTopics>(
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
                            'Select Topic',
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
                                'Select Topic',
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
                          topic = data!.name;
                          // categoryID = data.id.toString();
                        });
                      },
                      asyncItems: (filter) async {
                        var response = await Dio().get(
                          'https://con.duapa.online/api/v1/ticket/topic',
                          options: Options(
                            headers: {
                              'Accept': '*/*',
                              'Content-Type': 'application/json',
                              'Authorization': 'Bearer $token'
                            },
                          ),
                        );
                        var models = SupportTopics.fromJsonList(
                            response.data as List<dynamic>);
                        return models;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                  child: TextFromField(
                    icon: FontAwesomeIcons.message,
                    enabled: _isLoading ? false : true,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Required";
                      } else {
                        return null;
                      }
                    },
                    label: "Message",
                    secured: false,
                    textCapitalization: TextCapitalization.sentences,
                    inputType: TextInputType.multiline,
                    controller: message,
                    expands: true,
                    leftPadding: 20.0,
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
                _isLoading
                    ? const Padding(
                        padding: EdgeInsets.only(
                          left: 160.0,
                          right: 160,
                        ),
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballBeat,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: PrimaryButton(
                          text: 'Submit',
                          onPressed: () {
                            if (formKey!.currentState!.validate()) {
                              SupportTicketServices.sendTicket(
                                topic: topic!,
                                message: message.text,
                                context: context,
                              );
                              message.clear();
                              // topic.clear();
                              formKey!.currentState!.reset();
                            }
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
