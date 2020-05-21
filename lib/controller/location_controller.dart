import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:qibla_plus/model/constants.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

enum PermissionStatus { isGranted, isDenied, isUndetermined }

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
  PermissionStatus status;

  void getQibla() async {
    locationController = Location();
    await statusChecker();
    timer = Timer.periodic(Duration(minutes: 2), (Timer t) {
      statusChecker();
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
    await checkPermission();
    getLocation();
  }

  void getLocation() async {
    var location = await locationController.getLocation();
    print(location);
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

  //TODO: PermissionHandler
  Future<void> checkPermission() async {
    var tempStatus = await Permission.locationWhenInUse.status;
    if (tempStatus.isGranted) {
      errExists = false;
      status = PermissionStatus.isGranted;
      print('Location permission is granted');
      if (await Permission.locationWhenInUse.serviceStatus != ServiceStatus.enabled) {
        errExists = true;
        isLocationEnabled = false;
        print('Location services is disabled');
      }
    } else if (tempStatus.isUndetermined) {
      errExists = true;
      status = PermissionStatus.isUndetermined;
      print('Location Permission undetermined');
    } else {
      errExists = true;
      status = PermissionStatus.isDenied;
      print('Location Permission denied');
    }
    notifyListeners();
  }
}
