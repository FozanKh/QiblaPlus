import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:qibla_plus/model/constants.dart';
import 'dart:math' as math;
import 'dart:async';

enum Permission { isGranted, isDenied }

class LocationController extends ChangeNotifier {
  double lat;
  double lon;
  double angle;
  double heading;
  Location locationController;
  Timer timer;
  Color isExact = kTransparent;
  bool errExists = false;
  bool isLocationEnabled;
  Permission status;

  void getQibla() async {
    await statusChecker();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      print('StreamCalled');
//      statusChecker();
    });
    FlutterCompass.events.listen(
      (newHeading) {
        heading = (newHeading) * (math.pi / 180.0);
        if (heading != null) {
          getAngle();
        }
      },
    );
  }

  Future<void> statusChecker() async {
    if (locationController == null) locationController = Location();
    await checkPermission();
    getLocation();
  }

  void getLocation() async {
    var location = await locationController.getLocation();
    lat = location.latitude * math.pi / 180.0;
    lon = location.longitude * math.pi / 180.0;
  }

  Future<void> getAngle() async {
    if (lat != null && lon != null) {
      double x = math.cos(kKabbahLat) * math.sin(kKabbahLon - lon);
      double y = math.cos(lat) * math.sin(kKabbahLat) -
          math.sin(lat) * math.cos(kKabbahLat) * math.cos(kKabbahLon - lon);
      double diffAngle = math.atan2(x, y);
      angle = diffAngle - heading;

      isExact = (angle < 0.01 && angle > -0.01) ? null : kTransparent;
      notifyListeners();
    }
  }

  Future<void> checkPermission() async {
    var tempStatus = await locationController.hasPermission();
    if (tempStatus == PermissionStatus.granted) {
      errExists = false;
      status = Permission.isGranted;
      print('Location permission is granted');
      if (!await locationController.serviceEnabled()) {
        errExists = true;
        isLocationEnabled = false;
        print('Location services is disabled');
      }
    } else {
      errExists = true;
      status = Permission.isDenied;
      print("Location Permission isn't granted");
    }
    notifyListeners();
  }
}
