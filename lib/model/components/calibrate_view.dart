import 'package:flutter/material.dart';

class CalibrateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Please calibrate your compass'),
        Text('by moving your device as shown below', style: TextStyle(color: Colors.grey, fontSize: 12)),
        Image.asset('images/Calibration.gif'),
      ],
    );
  }
}
