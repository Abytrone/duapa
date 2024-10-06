import 'package:duapa/responsive_helper.dart';
import 'package:duapa/views/stores/widgets/store_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../models/service_providers_stores.dart';
import '../../services/constants.dart';
import '../../services/store_services.dart';
import '../../services/theme.dart';
import 'widgets/stores_shimmer.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  final StoreServices storeServices = StoreServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LayoutBuilder(builder: (context, constraints) {
          return Text(
            'Stores',
            style: TextStyle(
              fontSize: constraints.maxWidth < 768 ? 12 : 17,
              color: Theme.of(context).brightness ==
                      lightThemeData(context).brightness
                  ? kContentColorLightTheme
                  : kContentColorDarkTheme,
            ),
          );
        }),
        centerTitle: true,
        backgroundColor:
            Theme.of(context).brightness == lightThemeData(context).brightness
                ? kContentColorDarkTheme
                : kContentColorLightTheme,
        iconTheme: IconThemeData(
          color:
              Theme.of(context).brightness == lightThemeData(context).brightness
                  ? kContentColorLightTheme
                  : kContentColorDarkTheme,
        ),
      ),
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: LayoutBuilder(builder: (context, constraints) {
        return FutureBuilder(
          future: storeServices.getStores(),
          builder: (context, AsyncSnapshot<ServiceProvidersStores> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ResponsiveHelper(
                mobile: ListView.builder(
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return StoresShimmer(
                        constraints: constraints,
                      );
                    }),
                tablet: MasonryGridView.count(
                  padding: const EdgeInsets.all(10),
                  crossAxisCount: 2,
                  itemCount: 7,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return StoresShimmer(
                      constraints: constraints,
                    );
                  },
                ),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data!.message != null) {
                return const Center(
                  child: Text('No data available yet'),
                );
              } else {
                return ResponsiveHelper(
                  mobile: ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        return StoreCard(
                          store: snapshot.data!.data![index],
                          constraints: constraints,
                        );
                      }),
                  tablet: SingleChildScrollView(
                    child: MasonryGridView.count(
                      padding: const EdgeInsets.all(10),
                      crossAxisCount: 2,
                      itemCount: snapshot.data!.data!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return StoreCard(
                          store: snapshot.data!.data![index],
                          constraints: constraints,
                        );
                      },
                    ),
                  ),
                );
              }
            } else {
              return const Center(
                child: Text('No Data!'),
              );
            }
          },
        );
      }),
    );
  }
}
