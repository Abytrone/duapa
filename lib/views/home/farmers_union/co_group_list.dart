import 'dart:math';

import 'package:duapa/controllers/user_controller.dart';
import 'package:duapa/models/coporations_class.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/remote_services.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/home/farmers_union/add_group.dart';
import 'package:duapa/views/home/farmers_union/co_group_detail.dart';
// import 'package:duapa/views/home_screen/farmers_union/co_group_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoporateGroupScreen extends StatefulWidget {
  const CoporateGroupScreen({super.key});

  @override
  State<CoporateGroupScreen> createState() => _CoporateGroupScreenState();
}

class _CoporateGroupScreenState extends State<CoporateGroupScreen> {
  final RemoteServices _remoteServices = RemoteServices();

  final UserController userController = Get.find();
  // AppBar pop up menu actions
  void selectedItem(BuildContext context, item) {
    switch (item) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddCoporateGroup(),
          ),
        );
        break;
    }
  }

  Random random = Random();

  String generateRandomHexColor() {
    int length = 6;
    String chars = '0123456789ABCDEF';
    String hex = '0x';
    while (length-- > 0) {
      hex += chars[(random.nextInt(16)) | 0];
    }
    return hex;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Duapa Farmers Union',
            style: TextStyle(
              fontSize: constraints.maxWidth < 768 ? 12 : 17,
              color: Theme.of(context).brightness ==
                      lightThemeData(context).brightness
                  ? kContentColorLightTheme
                  : kContentColorDarkTheme,
            ),
          ),
          actions: [
            userController.user.value.value?.user.role == 'Farmer'
                ? PopupMenuButton<int>(
                    icon: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(Icons.menu),
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 1,
                        child: Text(
                          'Create Group',
                          style: TextStyle(
                              fontSize: constraints.maxWidth < 768 ? 14 : 24),
                        ),
                      ),
                    ],
                    onSelected: (item) => selectedItem(context, item),
                  )
                : const SizedBox.shrink(),
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
        body: FutureBuilder<Coporates?>(
          future: _remoteServices.getGroups(),
          builder: (BuildContext context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return snapshot.data == null
                    ? const Center(
                        child: Text('No Data'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: snapshot.data!.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              padding: const EdgeInsets.all(10),
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
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CoporateGroupDetailScreen(
                                        group: snapshot.data!.data[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(60)),
                                      child: Image(
                                        height: constraints.maxWidth < 768
                                            ? 50
                                            : 80,
                                        width: constraints.maxWidth < 768
                                            ? 50
                                            : 80,
                                        fit: BoxFit.contain,
                                        image: const AssetImage(
                                            'assets/icon/people.png'),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data!.data[index].groupName!,
                                          style: TextStyle(
                                            fontSize: constraints.maxWidth < 768
                                                ? 12
                                                : 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          '${snapshot.data!.data[index].country}, ${snapshot.data!.data[index].region}, ${snapshot.data!.data[index].city}',
                                          style: TextStyle(
                                            fontSize: constraints.maxWidth < 768
                                                ? 12
                                                : 20,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Stack(
                                          alignment: Alignment.centerRight,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20)),
                                                color: Color(int.parse(
                                                        generateRandomHexColor()))
                                                    .withOpacity(0.2),
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '${snapshot.data!.data[index].farmersCount}',
                                                    style: TextStyle(
                                                      fontSize:
                                                          constraints.maxWidth <
                                                                  768
                                                              ? 12
                                                              : 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  Text(
                                                    ' Subscribers',
                                                    style: TextStyle(
                                                      fontSize:
                                                          constraints.maxWidth <
                                                                  768
                                                              ? 12
                                                              : 20,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
              case ConnectionState.none:
                return const Center(
                  child: Text('No data found'),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      );
    });
  }
}
