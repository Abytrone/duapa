import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../services/constants.dart';

class AbyDropdownFormField extends StatefulWidget {
  const AbyDropdownFormField({
    super.key,
    required this.constraints,
    required this.onSaved,
  });
  final BoxConstraints constraints;
  final void Function(String?)? onSaved;

  @override
  State<AbyDropdownFormField> createState() => _AbyDropdownFormFieldState();
}

class _AbyDropdownFormFieldState extends State<AbyDropdownFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        height: 53.0,
        width: widget.constraints.maxWidth < 768
            ? widget.constraints.maxWidth
            : 300,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(blurRadius: 10.0, color: Colors.black12)
            ]),
        padding: const EdgeInsets.only(left: 10.0),
        child: DropdownSearch(
          selectedItem: 'MTN',
          items: const ['MTN', 'VODAFONE', 'TIGO'],
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              label: Text('Network Provider'),
              border: InputBorder.none,
              icon: Icon(Iconsax.wallet),
            ),
          ),
          onSaved: widget.onSaved,
        ),
      ),
    );
  }
}

class AbyTextField extends StatelessWidget {
  const AbyTextField({
    super.key,
    this.label,
    this.hintText,
    this.icon,
    this.inputType,
    this.controller,
    this.validate,
    this.onSaved,
    required this.constraints,
  });

  final IconData? icon;
  final String? label;
  final String? hintText;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final BoxConstraints constraints;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        height: 53,
        width: (constraints.maxWidth) < 768 ? constraints.maxWidth : 300,
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
        child: TextFormField(
          validator: validate,
          onSaved: onSaved,
          controller: controller,
          style: const TextStyle(
            fontFamily: 'Gotik',
            color: kContentColorLightTheme,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            labelText: label,
            prefixIcon: const Icon(
              Iconsax.call,
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
