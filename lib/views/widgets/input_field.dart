import 'package:duapa/services/constants.dart';
import 'package:flutter/material.dart';

/// textfromfield custom class
// ignore: must_be_immutable
class TextFromField extends StatelessWidget {
  final IconData? icon;
  final IconButton? sufIcon;
  final String? label;
  final String? hintText;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final bool? secured;
  final TextCapitalization? textCapitalization;
  final InputDecoration? deco;
  final String? Function(String?)? validate;
  final int? maxLines;
  final int? minLines;
  double? height = 80.0;
  final double? leftPadding;
  final bool? enabled;
  final double? width;
  bool? expands;

  TextFromField({
    super.key,
    this.label,
    this.hintText,
    this.icon,
    this.inputType,
    this.controller,
    this.secured,
    this.textCapitalization,
    this.deco,
    this.sufIcon,
    this.validate,
    this.maxLines,
    this.minLines,
    this.height,
    this.leftPadding,
    this.enabled,
    this.width,
    this.expands,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: height,
          width: (constraints.maxWidth) < 768 ? constraints.maxWidth : 500,
          alignment: AlignmentDirectional.topCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 10.0,
                color: Colors.black12,
              ),
            ],
          ),
          padding: EdgeInsets.only(left: leftPadding!, right: 20.0),
          child: TextFormField(
            validator: validate,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textCapitalization: textCapitalization!,
            obscureText: secured!,
            controller: controller,
            maxLines: maxLines,
            minLines: minLines,
            // expands: expands!,
            enabled: enabled ?? true,
            style: const TextStyle(
              fontFamily: 'Gotik',
              color: kContentColorLightTheme,
              fontSize: 15,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              labelText: label,
              suffixIcon: sufIcon,
              prefixIcon: Icon(
                icon,
                color: Colors.black38,
              ),
              labelStyle: const TextStyle(
                fontSize: 15.0,
                color: kContentColorLightTheme,
              ),
            ),
            keyboardType: inputType,
          ),
        ),
      );
    });
  }
}

// ignore: must_be_immutable
class TextFromFieldShort extends StatelessWidget {
  final IconData? icon;
  final IconButton? sufIcon;
  final String? label;
  final String? hintText;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final bool? secured;
  final TextCapitalization? textCapitalization;
  final InputDecoration? deco;
  final String? Function(String?)? validate;
  final int? maxLines;
  double? height = 80.0;
  final double? leftPadding;
  final bool enabled;
  final double? width;
  double left = 30;
  double right = 30;

  TextFromFieldShort({
    super.key,
    this.label,
    this.hintText,
    this.icon,
    this.inputType,
    this.controller,
    this.secured,
    this.textCapitalization,
    this.deco,
    this.sufIcon,
    this.validate,
    this.maxLines,
    this.height,
    this.leftPadding,
    required this.enabled,
    this.width,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right),
      child: Container(
        height: height,
        width: width,
        alignment: AlignmentDirectional.topStart,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 10.0,
              color: Colors.black12,
            ),
          ],
        ),
        padding: EdgeInsets.only(left: leftPadding!, right: 10.0),
        child: TextFormField(
          validator: validate,
          cursorWidth: 1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: textCapitalization!,
          obscureText: secured!,
          controller: controller,
          maxLines: maxLines,
          enabled: enabled,
          style: const TextStyle(
            fontFamily: 'Gotik',
            color: kContentColorLightTheme,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            labelText: label,
            suffixIcon: sufIcon,
            prefixIcon: Icon(
              icon,
              color: Colors.black38,
            ),
            labelStyle: const TextStyle(
              fontSize: 15.0,
              color: kContentColorLightTheme,
            ),
          ),
          keyboardType: inputType,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DialogTextField extends StatelessWidget {
  final IconData? icon;
  final IconButton? sufIcon;
  final String? label;
  final String? hintText;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final bool? secured;
  final TextCapitalization? textCapitalization;
  final InputDecoration? deco;
  final String? Function(String?)? validate;
  final int? maxLines;
  double? height = 80.0;
  final double? leftPadding;
  final bool enabled;
  final double? width;
  double? horizontalPadding = 30.0;
  String? initialValue;
  bool? expands;

  DialogTextField({
    super.key,
    this.label,
    this.hintText,
    this.icon,
    this.inputType,
    this.controller,
    this.secured,
    this.textCapitalization,
    this.deco,
    this.sufIcon,
    this.validate,
    this.maxLines,
    this.height,
    this.leftPadding,
    required this.enabled,
    this.width,
    required this.horizontalPadding,
    this.initialValue,
    this.expands,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding!),
      child: Container(
        height: height,
        width: 300,
        alignment: AlignmentDirectional.topCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 10.0,
              color: Colors.black12,
            ),
          ],
        ),
        padding: EdgeInsets.only(left: leftPadding!, right: 20.0),
        child: TextFormField(
          validator: validate,
          initialValue: initialValue,
          cursorWidth: 1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: textCapitalization!,
          obscureText: secured!,
          controller: controller,
          maxLines: maxLines,
          minLines: null,
          // expands: expands!,
          enabled: enabled,
          style: const TextStyle(
            fontFamily: 'Gotik',
            color: kContentColorLightTheme,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            labelText: label,
            suffixIcon: sufIcon,
            prefixIcon: Icon(
              icon,
              color: Colors.black38,
            ),
            labelStyle: const TextStyle(
              fontSize: 15.0,
              color: kContentColorLightTheme,
            ),
          ),
          keyboardType: inputType,
        ),
      ),
    );
  }
}
