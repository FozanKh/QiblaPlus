import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kKabbahLat = 0.3738927226761722; //21.4224750 deg
const kKabbahLon = 0.6950985611585316; //39.8262139 deg
const kArLangString = 'عربي';
const kEnLangString = 'English';
const kTransparent = Colors.transparent;
const kLightBlue = Color(0xff263a4c);
const kDarkBlue = Color(0xff4b7aa1);
const kGradientBackground = BoxDecoration(
  gradient: LinearGradient(
    colors: [kDarkBlue, kLightBlue],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  ),
);

const kLargTextStyle = TextStyle(
  fontSize: 40,
  color: Colors.white,
  fontWeight: FontWeight.w200,
);

const kSmallTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.white,
  fontWeight: FontWeight.w200,
  fontFamily: 'Dubai',
);

const kASmallTextStyle = TextStyle(
  fontSize: 15,
  color: Colors.white,
);

const kArTips = "نصائح لقبلة أدق:\n  عاير البوصلة بتدوير الجهاز على شكل 8  ♾\n  ابتعد عن "
    "الأجهزة الإلكترونية 🧲\n ضع هاتفك بشكل مسطح📱";

const kEnTibs = 'Tips for better qibla accuracy:\n ♾\t\tCalibrate compass by moving device in an '
    '8-figure\n🧲\tMove away from electronic devices\n📱\tLay your device flat';

const kArLocationErr = '⚠\nالرجاء إعطاء هذا التطبيق صلاحيات الموقع "أثناء الأستخدام" لمعرفة القبلة';
const kEnLocationErr = '⚠\n Please allow this app "while using the app" location priviliges to '
    'determine qibla direction';
