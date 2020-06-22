import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qibla_plus/model/constants.dart';

class EnglishTips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey('englishTips'),
      height: 150,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      child: Text(kEnTips, textAlign: TextAlign.left, style: kEnTipsTextStyle),
    );
  }
}

class ArabicTips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey('arabicTips'),
      height: 150,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerRight,
      child: Text(kArTips, textAlign: TextAlign.right, style: kArTipsTextStyle, textScaleFactor: 1.1),
    );
  }
}
