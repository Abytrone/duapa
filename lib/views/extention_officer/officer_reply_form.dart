import 'package:duapa/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/extension_service_controller.dart';
import '../../models/officer_query_class.dart';
import '../widgets/input_field.dart';
import '../widgets/primary_button.dart';

class OfficerReplyForm extends StatefulWidget {
  const OfficerReplyForm({super.key, required this.query});
  final OfficerQuery query;

  @override
  State<OfficerReplyForm> createState() => _OfficerReplyFormState();
}

class _OfficerReplyFormState extends State<OfficerReplyForm> {
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  final TextEditingController content = TextEditingController();
  final ExtensionServiceController extensionServiceController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Reply: ${widget.query.title}'),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                widget.query.description,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            TextFromField(
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return "* Required";
                } else {
                  return null;
                }
              },
              icon: Icons.message,
              label: "Message",
              secured: false,
              minLines: 10,
              inputType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              controller: content,
              leftPadding: 20.0,
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              text: 'Submit',
              onPressed: () {
                if (formKey!.currentState!.validate()) {
                  extensionServiceController.sendQueryReply(
                    id: widget.query.id.toString(),
                    content: content.text,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
