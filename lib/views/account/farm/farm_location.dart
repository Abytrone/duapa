import 'dart:async';
import 'dart:ui' as ui;

import 'package:duapa/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../services/theme.dart';

class FarmLocationScreen extends StatefulWidget {
  const FarmLocationScreen(
      {super.key, required this.longitude, required this.latitude});
  final double longitude;
  final double latitude;

  @override
  State<FarmLocationScreen> createState() => _FarmLocationScreenState();
}

class _FarmLocationScreenState extends State<FarmLocationScreen> {
  bool satellite = false;
  final Completer<GoogleMapController> _controller = Completer();
  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    // bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   // Location services are not enabled don't continue
    //   // accessing the position and request users of the
    //   // App to enable the location services.
    //   return Future.error('Location services are disabled.');
    // }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  // Convet image to bytes
  Future<Uint8List> convertImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Uint8List? farmIcon;
  // created method for displaying custom markers according to index
  loadData() async {
    final Uint8List markIcon =
        await convertImages('assets/icon/plant.png', 100);

    setState(() {
      farmIcon = markIcon;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  LatLng? myLocation;
  List<LatLng> path = [];

  @override
  Widget build(BuildContext context) {
    LatLng point = LatLng(widget.latitude, widget.longitude);
    void getPolyPoints() async {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        // PointLatLng(myLocation!.latitude, myLocation!.longitude),
        // PointLatLng(widget.latitude, widget.longitude),
        googleApiKey: 'AIzaSyB5_ByiKfoXpIHVop3lpvIQgQUOEkboLCA',
        request: PolylineRequest(
          origin: PointLatLng(myLocation!.latitude, myLocation!.longitude),
          destination: PointLatLng(widget.latitude, widget.longitude),
          mode: TravelMode.driving,
        ),
      );
      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          path.add(LatLng(point.latitude, point.longitude));
        }
        setState(() {});
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.latitude, widget.longitude),
              zoom: 15,
            ),
            zoomControlsEnabled: true,
            markers: {
              Marker(
                markerId: const MarkerId('farm'),
                position: point,
                infoWindow: const InfoWindow(title: 'Farm Location'),
                icon: farmIcon == null
                    ? BitmapDescriptor.defaultMarker
                    : BitmapDescriptor.fromBytes(farmIcon!),
              ),
              Marker(
                markerId: const MarkerId('myLocation'),
                position:
                    myLocation == null ? const LatLng(0.0, 0.0) : myLocation!,
                infoWindow: const InfoWindow(title: 'My Location'),
              ),
            },
            myLocationEnabled: true,
            mapType: satellite ? MapType.satellite : MapType.normal,
            polylines: {
              Polyline(
                polylineId: const PolylineId('route'),
                points: path,
                color: kPrimaryColor,
                width: 6,
              ),
            },
            circles: {
              Circle(
                circleId: const CircleId('circle'),
                radius: 100,
                fillColor: kPrimaryColor.withOpacity(0.2),
                strokeColor: kPrimaryColor,
                strokeWidth: 2,
                center: point,
              ),
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
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
            bottom: 220,
            right: 9,
            child: FloatingActionButton(
              onPressed: () {
                if (myLocation == null) {
                  Get.snackbar(
                    'Warning Message',
                    'Please pick your location first',
                    colorText: Colors.white,
                    maxWidth: 350,
                    backgroundColor: kWarninngColor,
                    borderRadius: 5,
                    margin: const EdgeInsets.only(bottom: 30),
                    snackPosition: SnackPosition.BOTTOM,
                  );
                } else {
                  getPolyPoints();
                }
              },
              heroTag: 'getRoute',
              elevation: 4,
              backgroundColor: kPrimaryColor,
              child: const Icon(
                Icons.route,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 150,
            right: 9,
            child: FloatingActionButton(
              onPressed: () {
                getUserCurrentLocation().then((value) async {
                  // print("${value.latitude} ${value.longitude}");
                  setState(() {
                    myLocation = LatLng(value.latitude, value.longitude);
                  });

                  // specified current users location
                  CameraPosition cameraPosition = CameraPosition(
                    target: LatLng(value.latitude, value.longitude),
                    zoom: 14,
                  );

                  final GoogleMapController controller =
                      await _controller.future;
                  controller.animateCamera(
                      CameraUpdate.newCameraPosition(cameraPosition));
                  setState(() {});
                });
              },
              heroTag: 'getMyLocation',
              elevation: 4,
              backgroundColor: Colors.white,
              child: Icon(
                FontAwesomeIcons.mapPin,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
