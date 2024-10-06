import 'package:duapa/services/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../services/constants.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ListView.separated(
        itemCount: 5,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return Container(
            width: constraints.maxWidth < 768 ? 10 : 20,
            color: Theme.of(context).brightness ==
                    lightThemeData(context).brightness
                ? kContentColorDarkTheme
                : kContentColorLightTheme,
          );
        },
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade50,
            child: Container(
              height: constraints.maxWidth < 768 ? 250 : 350,
              width: constraints.maxWidth < 768 ? 100 : 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10.0,
                    color: Colors.black12,
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
