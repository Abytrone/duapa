import 'package:duapa/services/theme.dart';
import 'package:flutter/material.dart';

import '../../services/constants.dart';
import '../widgets/squre_logo.dart';

class OtherGroupsScreen extends StatefulWidget {
  const OtherGroupsScreen({super.key});

  @override
  State<OtherGroupsScreen> createState() => _OtherGroupsScreenState();
}

class _OtherGroupsScreenState extends State<OtherGroupsScreen> {
  List<GroupData> groupList = GroupData.groupList;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    // mediaQueryData.devicePixelRatio;
    mediaQueryData.size.height;
    mediaQueryData.size.width;
    return Scaffold(
      appBar: AppBar(
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
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 10,
            right: 10,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: AlignmentDirectional.topCenter,
                  child: Column(
                    children: <Widget>[
                      /// padding logo
                      const SquareLogo(),
                      const SizedBox(height: 25),
                      const Text(
                        "Other Groups",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: SizedBox(
                          height: 400,
                          width: 350,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: groupList.length,
                            padding: const EdgeInsets.all(5),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: SizedBox(
                                      height: 112,
                                      child: GroupCard(
                                        groupData: groupList[index],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                      /// Button Login
                      Padding(
                        padding: const EdgeInsets.only(top: 0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('login');
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: kErrorColor,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GroupData {
  GroupData({
    this.ikon = '',
    this.title = '',
    this.route = '',
  });

  String ikon;
  String title;
  String route;

  static List<GroupData> groupList = <GroupData>[
    GroupData(
      ikon: 'assets/icon/manager.png',
      title: 'Extension\nServices',
      route: 'government',
    ),
    GroupData(
      ikon: 'assets/icon/bank.png',
      title: 'Duapa\nMicrocredit',
      route: 'coomingsoon',
    ),
    GroupData(
      ikon: 'assets/icon/teamwork.png',
      title: 'Duapa Farmers Union',
      route: 'coomingsoon',
    ),
    GroupData(
      ikon: 'assets/icon/megaphone.png',
      title: 'Duapa\nMarketing',
      route: 'coomingsoon',
    ),
    GroupData(
      ikon: 'assets/icon/rain.png',
      title: 'Weather\n(Climate Change)',
      route: 'coomingsoon',
    ),
    GroupData(
      ikon: 'assets/icon/delivery-truck.png',
      title: 'Duapa\nTransport',
      route: 'transport',
    ),
    GroupData(
      ikon: 'assets/icon/blogging.png',
      title: 'Duapa Blog',
      route: 'coomingsoon',
    ),
    GroupData(
      ikon: 'assets/icon/clipboard.png',
      title: 'Duapa\nInsurance',
      route: 'coomingsoon',
    ),
  ];
}

class GroupCard extends StatelessWidget {
  const GroupCard({super.key, this.groupData});
  final GroupData? groupData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(groupData!.route);
      },
      child: Card(
        elevation: 0,
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  width: 30,
                  image: AssetImage(groupData!.ikon),
                ),
                const SizedBox(height: 5),
                Text(
                  groupData!.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w200,
                    color: kContentColorLightTheme,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
