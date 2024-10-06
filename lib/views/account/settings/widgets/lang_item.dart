import 'package:duapa/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LangItem extends StatelessWidget {
  const LangItem({
    super.key,
    required this.onTap,
    required this.countryEmoji,
    required this.text,
    required this.buttonColor,
    required this.textColor,
    required this.isSelected,
  });
  final void Function()? onTap;
  final String countryEmoji;
  final String text;
  final Color buttonColor;
  final Color textColor;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
        child: Container(
          height: 50,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    countryEmoji,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                ],
              ),
              isSelected == true
                  ? const Icon(
                      FontAwesomeIcons.circleCheck,
                      color: kPrimaryColor,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
