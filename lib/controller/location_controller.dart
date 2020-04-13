import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:qibla_plus/model/constants.dart';
import 'dart:math' as math;

class LocationController extends ChangeNotifier {
  double lat;
  double lon;
  double angle;
  double heading;
  Location locationController;

  void getQibla() async {
    locationController = Location();
    FlutterCompass.events.listen((newHeading) {
      heading = (newHeading) * (math.pi / 180);
      if (heading != null) {
        getAngle();
      }
    });
  }

  getLocation() async {
    var location = await locationController.getLocation();
    lat = location.latitude * math.pi / 180;
    lon = location.longitude * math.pi / 180;
  }

  Future<void> getAngle() async {
    getLocation();
    if (lat != null && lon != null) {
      double x = math.cos(kMakkahLat) * math.sin(kMakkahLon - lon);
      double y = math.cos(lat) * math.sin(kMakkahLat) -
          math.sin(lat) * math.cos(kMakkahLat) * math.cos(kMakkahLon - lon);
      double diffAngle = math.atan2(x, y);

      angle = diffAngle - heading;
      notifyListeners();
    }
  }

//  var s = StreamBuilder<double>(
//    stream: FlutterCompass.events,
//    builder: (context, snapshot) {
//      if (snapshot.hasError) {
//        return Text('Error reading heading: ${snapshot.error}');
//      }
//
//      if (snapshot.connectionState == ConnectionState.waiting) {
//        return Center(
//          child: CircularProgressIndicator(),
//        );
//      }
//
//      double direction = snapshot.data;
//
//      // if direction is null, then device does not support this sensor
//      // show error message
//      if (direction == null)
//        return Center(
//          child: Text("Device does not have sensors !"),
//        );
//
//      return Container(
//        alignment: Alignment.center,
//        child: Transform.rotate(
//          angle: ((direction ?? 0) * (math.pi / 180) * -1),
//          child: Image.asset('assets/compass.jpg'),
//        ),
//      );
//    },
//  );

}