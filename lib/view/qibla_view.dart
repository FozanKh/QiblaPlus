import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qibla_plus/controller/location_controller.dart';
import 'package:qibla_plus/model/constants.dart';
import 'package:qibla_plus/controller/logic_controller.dart';

class QiblaView extends StatefulWidget {
  @override
  _QiblaViewState createState() => _QiblaViewState();
  final logic;
  QiblaView({this.logic});
}

class _QiblaViewState extends State<QiblaView> {
  LogicController logic;
  @override
  void initState() {
    Provider.of<LocationController>(context, listen: false).getQibla();
    logic = widget.logic; //LogicController();
  }

  Widget getErrMessage() {}

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
                        setState(() {
                          logic.updateLang();
                        });
                      },
                    ),
                    Hero(
                      tag: 'qabba',
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 3 * MediaQuery.of(context).size.width / 4,
                      child: Stack(
                        children: <Widget>[
                          Image.asset('images/NeedleBase.png'),
                          (location.errExists)
                              ? getErrMessage()
                              : Transform.rotate(
                                  angle: (location.angle ?? 0),
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
                        ],
                      ),
                    ),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: logic.tipsAlignment,
                      child: Text(
                        logic.tips,
                        textAlign: logic.tipsTextAlignment,
                        style: kSmallTextStyle,
                      ),
                    )
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
