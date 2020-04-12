import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qibla_plus/controller/location_controller.dart';
import 'package:qibla_plus/model/constants.dart';

enum Lang { en, ar }

class QiblaView extends StatefulWidget {
  @override
  _QiblaViewState createState() => _QiblaViewState();
}

class _QiblaViewState extends State<QiblaView> {
  Lang currLang = Lang.en;

  @override
  void initState() {
    Provider.of<LocationController>(context, listen: false).getQibla();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.only(top: 50, bottom: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [kDarkBlue, kLightBlue],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      (currLang == Lang.en) ? currLang = Lang.ar : currLang = Lang.en;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 40),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'English',
                      style: kSmallTextStyle,
                    ),
                  ),
                ),
                Image.asset(
                  'images/logo.png',
                  height: 75,
                  width: 75,
                ),
                Text(
                  'Qibla+',
                  textAlign: TextAlign.center,
                  style: kLargTextStyle,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Stack(
                    children: <Widget>[
                      Image.asset('images/NeedleBase.png'),
                      Transform.rotate(
                        angle: (Provider.of<LocationController>(context).angle ?? 0),
                        child: Image.asset(
                          'images/Needle.png',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 110,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: (currLang == Lang.en) ? Alignment.centerLeft : Alignment.centerRight,
                  child: Text(
                    (currLang == Lang.en) ? kEnTibs : kArTips,
                    textAlign: (currLang == Lang.en) ? TextAlign.left : TextAlign.right,
                    style: kSmallTextStyle,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//class NeedleRotator extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return StreamBuilder<double>(
//        stream: FlutterCompass.events,
//        builder: (context, snapshot) {
//          if (snapshot.hasError) {
//            return Text('Error reading heading: ${snapshot.error}');
//          }
//
//          if (snapshot.connectionState == ConnectionState.waiting) {
//            return Center(
//              child: CircularProgressIndicator(),
//            );
//          }
//          var location = Location();
//          LocationController.printLocation();
//
//          double direction = (snapshot.data ?? 0);
//          setAngle(direction);
//          angle = ((direction ?? 0) * (math.pi / 180) * -1);
//          print(snapshot.data);
//          if (direction == null)
//            return Center(
//              child: Text("Device does not have sensors !"),
//            );
//          return Container();
//        });
//  }
//}
