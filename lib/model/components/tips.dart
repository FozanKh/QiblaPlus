import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qibla_plus/model/components/tips_row.dart';
import 'package:qibla_plus/model/constants.dart';

class ArabicTips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        key: ValueKey('arabicTips'),
        height: 150,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerRight,
        child: Column(
          children: <Widget>[
            TipsRow(text: 'Sssss', textAlign: TextAlign.center, icon: Icons.all_inclusive),
            TipsRow(text: 'Sssss', textAlign: TextAlign.center, icon: Icons.phone_iphone),
          ],
        ));
  }
}

class EnglishTips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey('englishTips'),
      height: 150,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.centerLeft,
      child: Text(kEnTips, textAlign: TextAlign.left, style: kSmallTextStyle),
    );
  }
}
