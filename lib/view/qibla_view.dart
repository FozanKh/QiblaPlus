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

class _QiblaViewState extends State<QiblaView> with SingleTickerProviderStateMixin {
  final LogicController logic;
  Widget currErr;
  bool showCalibration = false;
  Size screen;

  _QiblaViewState(this.logic);
  @override
  void reassemble() {
    super.reassemble();
    print('reassmbled');
    Provider.of<LocationController>(context, listen: false).checkStatus();
  }

  @override
  void initState() {
    super.initState();
    calibrate();
    Provider.of<LocationController>(context, listen: false).setUpQibla();
    Timer.periodic(Duration(minutes: 10), (Timer t) {
      calibrate();
    });
  }

  void calibrate() async {
    showCalibration = true;
    setState(() {});
    await Future.delayed(Duration(seconds: 4));
    showCalibration = false;
    setState(() {});
    await Future.delayed(Duration(milliseconds: 600));
    setState(() {});
  }

  void getErrMessage() {
    var temp = Provider.of<LocationController>(context, listen: false);
    if (!temp.isPermissionGranted)
      currErr = Container(alignment: Alignment.center, padding: EdgeInsets.all(20), child: Text(logic.permissionErr, style: kErrTextStyle, textAlign: TextAlign.center));
    else if (!temp.isLocationEnabled)
      currErr = Container(alignment: Alignment.center, padding: EdgeInsets.all(20), child: Text(logic.locationServicesErr, style: kErrTextStyle, textAlign: TextAlign.center));
    else
      currErr = Container(alignment: Alignment.center, padding: EdgeInsets.all(20), child: kErrText);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationController>(
      builder: (context, location, child) => Container(
        padding: EdgeInsets.only(top: 20, bottom: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: kGradientBackground,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: RawMaterialButton(
                        elevation: 10,
                        fillColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          logic.langString,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          setState(() {
                            logic.updateLang();
                          });
                        },
                      ),
                    ),
                    Hero(
                      tag: 'qabbah',
                      child: Image.asset(
                        'images/logo.png',
                        height: MediaQuery.of(context).size.width / 6,
                        width: MediaQuery.of(context).size.width / 6,
                        // height: 75,
                        // width: 75,
                      ),
                    ),
                    Text(
                      'Qibla +',
                      textAlign: TextAlign.center,
                      style: kLargeTextStyle,
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
                                shape: BoxShape.circle, color: Colors.white, border: Border.all(color: Colors.grey.shade200, width: 3), boxShadow: [BoxShadow(color: Colors.black87, blurRadius: 10)]),
                          ),
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 700),
                            child: showCalibration
                                ? CalibrateView()
                                : ValueListenableBuilder(
                                    valueListenable: location.errExists,
                                    builder: (context, value, child) {
                                      if (location.errExists.value) {
                                        getErrMessage();
                                      }
                                      return AnimatedSwitcher(
                                        duration: Duration(milliseconds: 700),
                                        child: location.errExists.value
                                            ? currErr
                                            : Transform.rotate(
                                                angle: location.angle ?? 0,
                                                child: Stack(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      logic.needleAsset,
                                                    ),
                                                    Image.asset(
                                                      'images/ExactQibla.png',
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
