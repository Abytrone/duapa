import 'package:duapa/services/constants.dart';
import 'package:duapa/services/theme.dart';
import 'package:flutter/material.dart';

class AccountItem extends StatelessWidget {
  const AccountItem({
    super.key,
    this.txt,
    required this.icon,
    this.tap,
    this.padding,
    this.color,
  });
  final String? txt;
  final IconData icon;
  final GestureTapCallback? tap;
  final double? padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 45.0),
              child: Divider(
                color: Theme.of(context).brightness ==
                        lightThemeData(context).brightness
                    ? kContentColorLightTheme.withOpacity(0.5)
                    : kContentColorDarkTheme.withOpacity(0.5),
              ),
            ),
            InkWell(
              onTap: tap,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Row(
                  children: <Widget>[
                    Icon(
                      icon,
                      color: color,
                      size: constraints.maxWidth < 768 ? 25.0 : 50,
                    ),
                    // Image.asset(
                    //   image!,
                    //   height: constraints.maxWidth < 768 ? 25.0 : 50,
                    //   color: color,
                    // ),
                    const SizedBox(width: 25),
                    Text(
                      txt!,
                      style: TextStyle(
                        fontSize: constraints.maxWidth < 768 ? 13 : 23,
                        fontWeight: constraints.maxWidth < 768
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: Theme.of(context).brightness ==
                                lightThemeData(context).brightness
                            ? kContentColorLightTheme
                            : kContentColorDarkTheme,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
