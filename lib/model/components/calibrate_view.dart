import 'package:flutter/material.dart';
import 'package:qibla_plus/controller/logic_controller.dart';
import 'package:qibla_plus/model/constants.dart';

class CalibrateView extends StatelessWidget {
  final Lang lang;
  String line1;
  String line2;
  CalibrateView({this.lang}) {
    if (lang == Lang.ar) {
      line1 = kArCalib1;
      line2 = kArCalib2;
    } else {
      line1 = kEnCalib1;
      line2 = kEnCalib2;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Stack(
        children: <Widget>[
          Image.asset('assets/images/Slow20Calibration.gif'),
          Padding(
            padding: EdgeInsets.only(top: 70, bottom: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(text: line1, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Tajawal', height: 1.3 /* , letterSpacing: 1 */), children: [
                      TextSpan(text: line2, style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ])),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70),
                  child: SizedBox(height: 3, child: LinearProgressIndicator()),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Text('Please calibrate your compass'),
// Text('by moving your device as shown below', style: TextStyle(color: Colors.grey, fontSize: 12)),
