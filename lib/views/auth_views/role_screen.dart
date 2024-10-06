import 'package:duapa/services/constants.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/widgets/squre_logo.dart';
import 'package:flutter/material.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  List<RoleData> roleList = RoleData.roleList;

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
      body: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: Container(
            alignment: AlignmentDirectional.topCenter,
            child: Column(
              children: <Widget>[
                /// padding logo
                const SquareLogo(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Select Your Role",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: constraints.maxWidth < 768 ? 20.0 : 30,
                    color: Theme.of(context).brightness ==
                            lightThemeData(context).brightness
                        ? kContentColorLightTheme
                        : kContentColorDarkTheme,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 35,
                  ),
                  child: SizedBox(
                    width: 300,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      shrinkWrap: true,
                      itemCount: roleList.length,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RoleCard(
                              roleData: roleList[index],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                /// Button Login
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: constraints.maxWidth < 768 ? 13 : 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).brightness ==
                                  lightThemeData(context).brightness
                              ? kContentColorLightTheme
                              : kContentColorDarkTheme,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('login');
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: kErrorColor,
                              fontSize: constraints.maxWidth < 768 ? 13 : 20,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class RoleData {
  RoleData({
    required this.ikon,
    required this.title,
    required this.route,
  });

  String ikon;
  String title;
  String route;

  static List<RoleData> roleList = <RoleData>[
    RoleData(
      ikon: 'assets/icon/farmer.png',
      title: 'Farmer',
      route: 'farmersignup',
    ),
    RoleData(
      ikon: 'assets/icon/manager.png',
      title: 'Service Providers',
      route: 'signup',
    ),
    RoleData(
      ikon: 'assets/icon/people.png',
      title: 'Other Groups',
      route: 'othergroups',
    ),
    RoleData(
      ikon: 'assets/icon/user.png',
      title: 'General Users',
      route: 'generaluser',
    ),
  ];
}

class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    this.roleData,
  });
  final RoleData? roleData;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(roleData!.route);
        },
        child: Card(
          elevation: 0,
          child: Container(
            height: constraints.maxWidth < 768 ? 120 : 550,
            width: constraints.maxWidth < 768 ? 120 : 550,
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
                    width: constraints.maxWidth < 768 ? 50 : 100,
                    image: AssetImage(roleData!.ikon),
                    // color: kPrimaryColor,
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      roleData!.title,
                      style: TextStyle(
                        fontSize: constraints.maxWidth < 768 ? 15 : 20,
                        fontWeight: FontWeight.w300,
                        color: kContentColorLightTheme,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
