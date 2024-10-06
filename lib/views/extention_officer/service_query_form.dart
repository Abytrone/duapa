import 'package:duapa/controllers/extension_service_controller.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/input_field.dart';

class ServiceQueryForm extends StatefulWidget {
  const ServiceQueryForm({super.key, required this.officerID});
  final String officerID;

  @override
  State<ServiceQueryForm> createState() => _ServiceQueryFormState();
}

class _ServiceQueryFormState extends State<ServiceQueryForm> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final ExtensionServiceController extensionServiceController = Get.find();
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Service Query Form'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFromField(
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return "* Required";
                  } else {
                    return null;
                  }
                },
                icon: Icons.title,
                label: "Title",
                secured: false,
                textCapitalization: TextCapitalization.words,
                controller: title,
                leftPadding: 20.0,
              ),
              const SizedBox(height: 10),
              TextFromField(
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return "* Required";
                  } else {
                    return null;
                  }
                },
                icon: Icons.description,
                label: "Description",
                secured: false,
                inputType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                controller: description,
                leftPadding: 20.0,
              ),
              const SizedBox(height: 20),
              // extensionServiceController.loading.isTrue
              //     ? const AbyLoading()
              //     :
              PrimaryButton(
                text: 'Submit',
                onPressed: () async {
                  if (formKey!.currentState!.validate()) {
                    final result =
                        await extensionServiceController.sendServiceQuery(
                      title: title.text,
                      description: description.text,
                      officerID: widget.officerID,
                    );
                    if (result) {
                      title.clear();
                      description.clear();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
