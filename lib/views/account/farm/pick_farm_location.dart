import 'package:duapa/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../services/farm_services.dart';
import '../../../services/theme.dart';

class PickFarmLocationScreen extends StatefulWidget {
  const PickFarmLocationScreen(
      {super.key, required this.body, required this.farmImage});
  final Map<String, String> body;
  final String farmImage;

  @override
  State<PickFarmLocationScreen> createState() => _PickFarmLocationScreenState();
}

class _PickFarmLocationScreenState extends State<PickFarmLocationScreen> {
  bool satellite = false;
  LatLng? point;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(9.4209988, -0.8363085),
              zoom: 15,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('value'),
                position: point == null ? const LatLng(0.0, 0.0) : point!,
              ),
            },
            myLocationEnabled: true,
            onLongPress: (value) {
              // print(value);
              setState(() {
                point = value;
              });
            },
            mapType: satellite ? MapType.satellite : MapType.normal,
            circles: {
              Circle(
                circleId: const CircleId('circle'),
                radius: 100,
                fillColor: kPrimaryColor.withOpacity(0.2),
                strokeColor: kPrimaryColor,
                strokeWidth: 2,
                center: point == null ? const LatLng(0.0, 0.0) : point!,
              ),
            },
          ),
          Positioned(
            top: 50,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness ==
                        lightThemeData(context).brightness
                    ? kContentColorDarkTheme
                    : kContentColorLightTheme,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop(context);
                },
                icon: Icon(
                  Icons.chevron_left,
                  color: Theme.of(context).brightness ==
                          lightThemeData(context).brightness
                      ? kContentColorLightTheme
                      : kContentColorDarkTheme,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            right: 9,
            child: FloatingActionButton(
              onPressed: () {
                if (satellite == false) {
                  setState(() {
                    satellite = true;
                  });
                } else {
                  setState(() {
                    satellite = false;
                  });
                }
              },
              elevation: 4,
              backgroundColor: Colors.white,
              child: Image(
                image: const AssetImage('assets/icon/stack.png'),
                color: Colors.grey.shade700,
                width: 25,
              ),
            ),
          ),
          Positioned(
            bottom: 150,
            right: 9,
            child: FloatingActionButton(
              onPressed: () {
                widget.body.addAll({
                  'longitude':
                      point == null ? '0.0' : point!.longitude.toString(),
                  'latitude':
                      point == null ? '0.0' : point!.latitude.toString(),
                });
                // print(widget.body);
                if (point != null) {
                  FarmServices.addFarm(
                    body: widget.body,
                    farmImage: widget.farmImage,
                  );
                } else {
                  AbySnackBar.warningSnackbar(
                      text:
                          'Please locate your farm on the map and tap and hold on the location to mark it before submiting.');
                }
              },
              heroTag: 'submit',
              elevation: 4,
              backgroundColor: kPrimaryColor,
              child: const Image(
                image: AssetImage('assets/icon/placeholder.png'),
                color: Colors.white,
                width: 30,
              ),
            ),
          ),
          // Positioned(
          //   bottom: 10,
          //   // right: 100,
          //   child: Container(
          //     height: 200,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.grey.shade100,
          //           blurRadius: 4,
          //           offset: const Offset(4, 8), // Shadow position
          //         ),
          //       ],
          //       borderRadius: const BorderRadius.only(
          //         topRight: Radius.circular(20.0),
          //         topLeft: Radius.circular(20.0),
          //       ),
          //     ),
          //     child: Column(
          //       children: [
          //         const Text(
          //             'Please when you are done selecting your cordinates\ntap on the button below to submit your farm location.'),
          //         PrimaryButton(
          //           text: 'Submit',
          //           onTap: () {},
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
