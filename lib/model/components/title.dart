import 'package:flutter/cupertino.dart';
import 'package:qibla_plus/model/constants.dart';

class ArabicTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      kArTitle,
      key: ValueKey('ArabicTitle'),
      style: kTitleTextStyle,
    );
  }
}

class EnglishTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      kEnTitle,
      key: ValueKey('EnglishTitle'),
      style: kTitleTextStyle,
    );
  }
}
