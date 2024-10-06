import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
    required this.buttonColor,
    required this.textColor,
  });
  final void Function()? onTap;
  final IconData icon;
  final String text;
  final Color buttonColor;
  final Color textColor;

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
            // border: Border.all(width: 3),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 25,
                color: textColor,
              ),
              const SizedBox(width: 5),
              Text(
                text, // 'Delete Account',
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
