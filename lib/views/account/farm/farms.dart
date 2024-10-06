import 'package:duapa/models/farms_class.dart';
import 'package:duapa/responsive_helper.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/account/farm/add_farm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../services/farm_services.dart';
import 'widgets/farm_card.dart';

class FarmsScreen extends StatefulWidget {
  const FarmsScreen({super.key});

  @override
  State<FarmsScreen> createState() => _FarmsScreenState();
}

class _FarmsScreenState extends State<FarmsScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Farms',
            style: TextStyle(
              fontSize: constraints.maxWidth < 768 ? 12 : 17,
              color: Theme.of(context).brightness ==
                      lightThemeData(context).brightness
                  ? kContentColorLightTheme
                  : kContentColorDarkTheme,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => const AddFarm());
              },
              icon: const Icon(
                Iconsax.add_square,
              ),
            ),
          ],
          centerTitle: true,
          backgroundColor:
              Theme.of(context).brightness == lightThemeData(context).brightness
                  ? kContentColorDarkTheme
                  : kContentColorLightTheme,
          iconTheme: IconThemeData(
            color: Theme.of(context).brightness ==
                    lightThemeData(context).brightness
                ? kContentColorLightTheme
                : kContentColorDarkTheme,
          ),
        ),
        backgroundColor:
            Theme.of(context).brightness == lightThemeData(context).brightness
                ? kContentColorDarkTheme
                : kContentColorLightTheme,
        body: Center(
          child: FutureBuilder<List<Farms>?>(
            future: FarmServices.getFarms(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasError) {
                  return const Center(child: Text('Error getting data!'));
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'You currently do not have any farm added.\nYou can add by tapping on the + button on the top right.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  );
                } else {
                  return ResponsiveHelper(
                    mobile: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return FarmCard(
                          farm: snapshot.data![index],
                          constraints: constraints,
                        );
                      },
                    ),
                    tablet: SingleChildScrollView(
                      child: MasonryGridView.count(
                        padding: const EdgeInsets.all(10),
                        crossAxisCount: 2,
                        itemCount: snapshot.data!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return FarmCard(
                            farm: snapshot.data![index],
                            constraints: constraints,
                          );
                        },
                      ),
                    ),
                  );
                }
                // case ConnectionState.waiting:
                //   return const Center(child: CircularProgressIndicator());
                // case ConnectionState.none:
                //   return const Center(
                //       child: Text('No data on found at the moment'));
                // default:
                //   return const Center(child: Text('wat the heck this'));
              }
            },
          ),
        ),
      );
    });
  }
}
