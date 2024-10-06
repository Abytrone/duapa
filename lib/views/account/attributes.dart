import 'package:duapa/models/asset_attributes_class.dart';
import 'package:flutter/material.dart';

import '../../services/constants.dart';
import '../../services/theme.dart';
import '../widgets/app_bar.dart';
import 'widgets/attribute_item.dart';

class AttributesScreen extends StatelessWidget {
  const AttributesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Attributes'),
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: ListView(
        shrinkWrap: true,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              'Onboarding Screens',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kLightGreyColor,
                fontSize: 15,
              ),
            ),
          ),
          ListView.builder(
            itemCount: onboardingAttributes.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return AttributeItem(
                image: onboardingAttributes[index].image,
                name: onboardingAttributes[index].name,
                url: onboardingAttributes[index].url,
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              'Home-Categories',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kLightGreyColor,
                fontSize: 15,
              ),
            ),
          ),
          ListView.builder(
            itemCount: categoriesAttributes.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return AttributeItem(
                image: categoriesAttributes[index].image,
                name: categoriesAttributes[index].name,
                url: categoriesAttributes[index].url,
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              'Home-Banner Section',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kLightGreyColor,
                fontSize: 15,
              ),
            ),
          ),
          ListView.builder(
            itemCount: bannerAttribute.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return AttributeItem(
                image: bannerAttribute[index].image,
                name: bannerAttribute[index].name,
                url: bannerAttribute[index].url,
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              'Home-Group Section',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kLightGreyColor,
                fontSize: 15,
              ),
            ),
          ),
          ListView.builder(
            itemCount: groupSection.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return AttributeItem(
                image: groupSection[index].image,
                name: groupSection[index].name,
                url: groupSection[index].url,
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              'Others',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kLightGreyColor,
                fontSize: 15,
              ),
            ),
          ),
          ListView.builder(
            itemCount: otherAttributes.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return AttributeItem(
                image: otherAttributes[index].image,
                name: otherAttributes[index].name,
                url: otherAttributes[index].url,
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text.rich(
              TextSpan(
                text: 'Note: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                      text:
                          'The names indicated on each item is the name given to the asset on this app and not the name the original creator gave to it.',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
