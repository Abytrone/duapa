import 'package:duapa/views/home/product_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/category_class.dart';
import '../../../services/constants.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard(
      {super.key, required this.category, required this.constraints});
  final Category category;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ProductCategoryScreen(
              id: '${category.id}',
              categoryName: category.categoryName,
            ));
      },
      child: Container(
        width: constraints.maxWidth < 768 ? 120 : 200,
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10.0,
              color: Colors.black12,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInImage.assetNetwork(
              height: constraints.maxWidth < 768 ? 90 : 130,
              width: constraints.maxWidth < 768 ? 60 : 90,
              placeholder: 'assets/img/placeholder.png',
              image: category.picture!,
            ),
            Text(
              category.categoryName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: constraints.maxWidth < 768 ? 13 : 20,
                fontWeight: FontWeight.bold,
                color: kContentColorLightTheme,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
