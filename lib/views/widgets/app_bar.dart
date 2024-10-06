import 'package:duapa/services/constants.dart';
import 'package:duapa/services/theme.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appBar({
  required BuildContext context,
  required String title,
  List<Widget>? actions,
  Widget? leading,
}) {
  return AppBar(
    leading: leading,
    title: LayoutBuilder(builder: (context, constraints) {
      return Text(
        title,
        style: TextStyle(
          fontSize: constraints.maxWidth < 768 ? 12 : 17,
          color:
              Theme.of(context).brightness == lightThemeData(context).brightness
                  ? kContentColorLightTheme
                  : kContentColorDarkTheme,
        ),
      );
    }),
    actions: actions,
    centerTitle: true,
    backgroundColor:
        Theme.of(context).brightness == lightThemeData(context).brightness
            ? kContentColorDarkTheme
            : kContentColorLightTheme,
    iconTheme: IconThemeData(
      color: Theme.of(context).brightness == lightThemeData(context).brightness
          ? kContentColorLightTheme
          : kContentColorDarkTheme,
    ),
  );
}
