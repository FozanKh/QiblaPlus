import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qibla_plus/controller/location_controller.dart';
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
  var listener;
  AnimationController animationController;
  Animation animation;
  Widget currErr;
  bool showCalibration = false;
  bool showNeedle = false;
  bool showErr = false;
  int currWidgetOpacity = 1;
  bool xx = false;

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
    Listener();
  }

  void calibrate() async {
    if (showErr || showNeedle) {
      showErr = false;
      showNeedle = false;
      await Future.delayed(Duration(milliseconds: 600));
    }
    showCalibration = true;
    setState(() {});
    await Future.delayed(Duration(seconds: 4));
    showCalibration = false;
    setState(() {});
    await Future.delayed(Duration(milliseconds: 600));

    if (Provider.of<LocationController>(context, listen: false).errExists.value) {
      getErrMessage();
      showErr = true;
    } else
      showNeedle = true;
    setState(() {});
  }

  void getErrMessage() {
    var temp = Provider.of<LocationController>(context, listen: false);
    if (temp.status != Permission.isGranted)
      currErr = Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Text(logic.permissionErr, style: kErrTextStyle, textAlign: TextAlign.center),
      );
    else if (!temp.isLocationEnabled)
      currErr = Container(alignment: Alignment.center, padding: EdgeInsets.all(20), child: Text(logic.locationServicesErr, style: kErrTextStyle, textAlign: TextAlign.center));
    else
      currErr = Container(alignment: Alignment.center, padding: EdgeInsets.all(20), child: kErrText);

    // setState(() {});
  }

  // void errExists() async {
  //   if (Provider.of<LocationController>(context).errExists.value) {
  //     getErrMessage();
  //     if (showCalibration || showNeedle) {
  //       showCalibration = false;
  //       showNeedle = false;
  //       await Future.delayed(Duration(milliseconds: 600));
  //     }
  //     showCalibration = true;
  //     setState(() {});
  //   }
  // }

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(right: 40),
                        alignment: Alignment.centerRight,
                        child: Text(
                          logic.langString,
                          style: kSmallTextStyle,
                        ),
                      ),
                      onTap: () {
                        // xx = xx ? false : true;
                        setState(() {
                          logic.updateLang();
                        });
                      },
                    ),
                    Hero(
                      tag: 'kabbah',
                      child: Image.asset(
                        'images/logo.png',
                        height: 75,
                        width: 75,
                      ),
                    ),
                    Text(
                      'Qibla+',
                      textAlign: TextAlign.center,
                      style: kLargTextStyle,
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
                          AnimatedOpacity(
                            opacity: (showCalibration) ? 1 : 0,
                            duration: Duration(milliseconds: 500),
                            child: Image.asset('images/Calibration.gif'),
                          ),
                          AnimatedOpacity(
                            opacity: (showCalibration) ? 0 : 1,
                            duration: Duration(milliseconds: 500),
                            child: ValueListenableBuilder(
                              valueListenable: location.errExists,
                              builder: (context, value, child) {
                                if (location.errExists.value) {
                                  getErrMessage();
                                }
                                return AnimatedCrossFade(
                                  crossFadeState: location.errExists.value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                  duration: Duration(milliseconds: 700),
                                  firstChild: Transform.rotate(
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
                                  secondChild: currErr ?? SizedBox(),
                                  layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) => Stack(
                                    overflow: Overflow.visible,
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Positioned(
                                        key: bottomChildKey,
                                        child: bottomChild,
                                      ),
                                      Positioned(
                                        key: topChildKey,
                                        child: topChild,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                          // AnimatedOpacity(
                          //   // opacity: (showErr) ? 1 : 0,
                          //   opacity: 0,
                          //   duration: Duration(milliseconds: 1200),
                          //   child: currErr,
                          // ),
                          // AnimatedOpacity(
                          //   // opacity: (showNeedle) ? 1 : 0,
                          //   opacity: 1,
                          //   duration: Duration(milliseconds: 500),
                          //   child: Transform.rotate(
                          //     angle: location.angle ?? 0,
                          //     child: Stack(
                          //       children: <Widget>[
                          //         Image.asset(
                          //           logic.needleAsset,
                          //         ),
                          //         Image.asset(
                          //           'images/ExactQibla.png',
                          //           color: location.isExact,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: logic.tips,
                    ),
                    // Container(
                    //   height: 150,
                    //   width: MediaQuery.of(context).size.width,
                    //   padding: EdgeInsets.symmetric(horizontal: 10),
                    //   alignment: logic.tipsAlignment,
                    //   child: Text(
                    //     logic.tips,
                    //     textAlign: logic.tipsTextAlignment,
                    //     style: kSmallTextStyle,
                    //   ),
                    // )
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

//        animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
//    animationController.forward();

//Visibility(
//                              visible: showCalibration,
//                              child: Image.asset('images/Calibration.gif'),
//                            ),
//                            AnimatedOpacity(
//                              opacity: 1,
//                              duration: Duration(milliseconds: 500),
//                              child: (location.errExists)
//                                  ? getErrMessage()
//                                  : Transform.rotate(
//                                      angle: location.angle ?? 0,
//                                      child: Stack(
//                                        children: <Widget>[
//                                          Image.asset(
//                                            logic.needleAsset,
//                                          ),
//                                          Image.asset(
//                                            'images/ExactQibla.png',
//                                            color: location.isExact,
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                            ),
// FadeTransition(
//                              opacity: animation,
//                              child: getCurrWidget(),
//                            )
