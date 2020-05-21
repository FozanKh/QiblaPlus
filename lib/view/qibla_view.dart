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
  void reassemble() {
    Provider.of<LocationController>(context, listen: false).checkStatus();
  }

  @override
  void initState() {
    Provider.of<LocationController>(context, listen: false).setUpQibla();
    logic = widget.logic; //LogicController();
  }

  Widget getErrMessage() {
    var temp = Provider.of<LocationController>(context, listen: false);
    if (temp.status != Permission.isGranted)
      return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Text(logic.permissionErr, style: kErrTextStyle, textAlign: TextAlign.center));
    else if (!temp.isLocationEnabled)
      return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child:
              Text(logic.locationServicesErr, style: kErrTextStyle, textAlign: TextAlign.center));
    else
      return Container(alignment: Alignment.center, padding: EdgeInsets.all(20), child: kErrText);
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints.tightFor(
                          width: 3 * MediaQuery.of(context).size.width / 4,
                          height: 3 * MediaQuery.of(context).size.width / 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('images/NeedleBase.png'),
                        ),
                      ),
                      child: (location.errExists)
                          ? getErrMessage()
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
