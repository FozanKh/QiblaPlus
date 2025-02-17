import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qibla_plus/controller/location_controller.dart';
import 'package:qibla_plus/model/components/calibrate_view.dart';
import 'package:qibla_plus/model/constants.dart';
import 'package:qibla_plus/controller/logic_controller.dart';

class QiblaView extends StatefulWidget {
  final logic;
  QiblaView({this.logic});
  @override
  _QiblaViewState createState() => _QiblaViewState(this.logic);
}

class _QiblaViewState extends State<QiblaView> {
  final LogicController logic;
  Widget currErr;
  bool showCalibration = false;
  Size screen;

  _QiblaViewState(this.logic);

  @override
  void initState() {
    super.initState();
    calibrate();
    Timer.periodic(Duration(minutes: 10), (Timer t) {
      calibrate();
    });
  }

  @override
  reassemble() {
    var temp = Provider.of<LocationController>(context, listen: false);
    print(temp.lat);
    print(temp.lon);
    print('angle ${temp.angle}');
    print('angle ${temp.errExists.value}');
    print('Stream ${temp.headingStream}');
    print('Stream ${temp.timer}');
    print('Stream ${temp}');
  }

  void calibrate() async {
    showCalibration = true;
    setState(() {});
    await Future.delayed(Duration(seconds: 4));
    showCalibration = false;
    setState(() {});
  }

  Widget getErrMessage() {
    var temp = Provider.of<LocationController>(context, listen: false);
    if (!temp.isPermissionGranted)
      return Container(alignment: Alignment.center, padding: EdgeInsets.all(40), child: Text(logic.permissionErr, style: kErrTextStyle, textAlign: TextAlign.center));
    else if (!temp.isLocationEnabled)
      return Container(alignment: Alignment.center, padding: EdgeInsets.all(40), child: Text(logic.locationServicesErr, style: kErrTextStyle, textAlign: TextAlign.center));
    else if (temp.lat == null || temp.lon == null)
      return Container(alignment: Alignment.center, padding: EdgeInsets.all(40), child: Text(logic.loadingMessage, style: kErrTextStyle, textAlign: TextAlign.center));
    else
      return Container(alignment: Alignment.center, padding: EdgeInsets.all(40), child: kErrText);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationController>(
      builder: (context, location, child) => WillPopScope(
        onWillPop: () {},
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, bottom: MediaQuery.of(context).padding.bottom, right: 20, left: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: kGradientBackground,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            width: 80,
                            height: 30,
                            alignment: Alignment.center,
                            decoration:
                                BoxDecoration(color: Colors.white, shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(blurRadius: 3, color: Colors.black26)]),
                            child: Text(
                              logic.langString,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              logic.updateLang();
                            });
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Hero(
                        tag: 'logo',
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: MediaQuery.of(context).size.width / 6,
                          width: MediaQuery.of(context).size.width / 6,
                          // height: 75,
                          // width: 75,
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      child: logic.title,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints.tightFor(width: 3 * MediaQuery.of(context).size.width / 4, height: 3 * MediaQuery.of(context).size.width / 4),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints.tightFor(width: 3 * MediaQuery.of(context).size.width / 4 - 25, height: 3 * MediaQuery.of(context).size.width / 4 - 25),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white, border: Border.all(color: Colors.grey.shade200, width: 3), boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)]),
                          ),
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 700),
                            child: showCalibration
                                ? CalibrateView(lang: logic.currLang)
                                : ValueListenableBuilder(
                                    valueListenable: location.errExists,
                                    builder: (context, value, child) {
                                      return AnimatedSwitcher(
                                        duration: Duration(milliseconds: 700),
                                        child: location.errExists.value || location.lat == null
                                            ? getErrMessage()
                                            : Transform.rotate(
                                                angle: location.angle ?? 0,
                                                child: Stack(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      logic.needleAsset,
                                                    ),
                                                    Image.asset(
                                                      'assets/images/ExactQibla.png',
                                                      color: location.isExact,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      );
                                    },
                                  ),
                          )
                        ],
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: logic.tips,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
