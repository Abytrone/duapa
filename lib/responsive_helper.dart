import 'package:flutter/material.dart';

class ResponsiveHelper extends StatelessWidget {
  const ResponsiveHelper({super.key, this.mobile, this.tablet});
  final Widget? mobile;
  final Widget? tablet;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        if (constraint.maxWidth < 768) {
          return mobile!;
        } else {
          return tablet!;
        }
      },
    );
  }
}
