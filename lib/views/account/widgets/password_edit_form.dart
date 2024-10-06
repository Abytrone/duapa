import 'package:flutter/material.dart';

import '../../../services/constants.dart';
import '../../../services/profile_services.dart';
import '../../widgets/input_field.dart';

class PasswordForm extends StatefulWidget {
  const PasswordForm({super.key});

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  // for password change
  TextEditingController oldpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  bool secure = true;
  bool psecured = true;
  bool csecured = true;
  final bool _isLoading = false;
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  final ProfileServices profileServices = ProfileServices();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          /// TextFromField Old password
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: TextFromField(
              icon: Icons.lock_outline_rounded,
              enabled: _isLoading ? false : true,
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return "* Required";
                } else {
                  return null;
                }
              },
              sufIcon: IconButton(
                  icon: Icon(secure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                  color: Colors.grey,
                  onPressed: () {
                    setState(() {
                      secure = !secure;
                    });
                  }),
              label: "Old password",
              secured: secure,
              textCapitalization: TextCapitalization.none,
              inputType: TextInputType.text,
              controller: oldpassword,
              maxLines: 1,
              leftPadding: 20.0,
            ),
          ),

          /// TextFromField New password
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: TextFromField(
              icon: Icons.lock_outline_rounded,
              enabled: _isLoading ? false : true,
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return "* Required";
                } else {
                  return null;
                }
              },
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
              label: "New password",
              secured: psecured,
              textCapitalization: TextCapitalization.none,
              inputType: TextInputType.text,
              controller: newpassword,
              maxLines: 1,
              leftPadding: 20.0,
            ),
          ),

          /// TextFromField Confirm password
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: TextFromField(
              icon: Icons.lock_outline_rounded,
              enabled: _isLoading ? false : true,
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return "* Required";
                } else if (value != newpassword.text) {
                  return "* Passwords don't match";
                } else {
                  return null;
                }
              },
              sufIcon: IconButton(
                  icon: Icon(
                    csecured
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  color: Colors.grey,
                  onPressed: () {
                    setState(() {
                      csecured = !csecured;
                    });
                  }),
              label: "Confirm new password",
              secured: csecured,
              textCapitalization: TextCapitalization.none,
              inputType: TextInputType.text,
              controller: confirmpassword,
              maxLines: 1,
              leftPadding: 20.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    if (formKey!.currentState!.validate()) {
                      Map<String, String> body = {
                        'old_password': oldpassword.text,
                        'new_password': newpassword.text,
                        'confirm_password': confirmpassword.text,
                      };
                      final res = await profileServices.updatePassword(
                        body: body,
                        context: context,
                      );
                      if (res == true) {
                        oldpassword.clear();
                        newpassword.clear();
                        confirmpassword.clear();
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Center(
                        child: Text(
                          'Update Password',
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
