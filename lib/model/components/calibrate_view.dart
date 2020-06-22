import 'package:flutter/material.dart';

class CalibrateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Please calibrate your compass'),
          Text('by moving your device as shown below', style: TextStyle(color: Colors.grey, fontSize: 12)),
          Image.asset('assets/images/Calibration.gif'),
        ],
      ),
    );
  }
}
