import 'package:flutter/material.dart';
import 'package:qibla_plus/model/constants.dart';

class kArabicTips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10),
      alignment: logic.tipsAlignment,
      child: Text(
        logic.tips,
        textAlign: logic.tipsTextAlignment,
        style: kSmallTextStyle,
      ),
    );
  }
}
