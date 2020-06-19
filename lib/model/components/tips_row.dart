import 'package:flutter/material.dart';
import 'package:qibla_plus/model/constants.dart';

class TipsRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextAlign textAlign;

  const TipsRow({this.icon, this.text, this.textAlign});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: icon is IconData ? Icon(icon) : Text('$icon'),
          ),
          Text(text, textAlign: textAlign, style: kSmallTextStyle),
        ],
      ),
    );
  }
}
