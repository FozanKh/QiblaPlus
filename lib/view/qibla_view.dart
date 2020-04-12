import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qibla_plus/model/constants.dart';

class QiblaView extends StatefulWidget {
  @override
  _QiblaViewState createState() => _QiblaViewState();
}

enum Lang { en, ar }

class _QiblaViewState extends State<QiblaView> {
  Lang currLang = Lang.en;
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
            colors: [Color(0xff4b7aa1), Color(0xff263a4c)],
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
                      Image.asset(
                        'images/NeedleBase.png',
                      ),
                      Image.asset('images/Needle.png'),
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
