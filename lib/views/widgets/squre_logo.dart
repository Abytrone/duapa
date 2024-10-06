import 'package:flutter/material.dart';

class SquareLogo extends StatelessWidget {
  const SquareLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.only(top: constraints.maxWidth < 768 ? 30 : 150.0),
        child: Center(
          child: Container(
            height: constraints.maxWidth < 768 ? 100 : 200,
            width: constraints.maxWidth < 768 ? 100 : 200,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: Border.all(
                width: 1,
              ),
              image: const DecorationImage(
                image: AssetImage('assets/app_icon/icon.png'),
              ),
            ),
          ),
        ),
      );
    });
  }
}
