import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kKabbahLat = 0.3738927226761722; //21.4224750 deg
const kKabbahLon = 0.6950985611585316; //39.8262139 deg
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

const kLargeTextStyle = TextStyle(
  fontSize: 40,
  color: Colors.white,
  fontWeight: FontWeight.w200,
);

const kSmallTextStyle = TextStyle(
  fontSize: 16,
  color: Colors.white,
  fontWeight: FontWeight.w200,
);

const kErrTextStyle = TextStyle(
  fontSize: 15,
  color: Colors.black,
  fontWeight: FontWeight.w600,
  // fontFamily: 'Dubai',
);

//Language Strings--------------------------------------------------------------------------------
const kArLangString = 'عــــربـــــي';
const kEnLangString = 'English';

const kEnTitle = 'Qibla +';
const kArTitle = '+ قبلة';

const kArTips = ": نصائح لقبلة أدق\n  عاير البوصلة بتدوير الجهاز على شكل الرقم 8 ♾️\n  ابتعد عن "
    "الأجهزة الإلكترونية 🧲\n ضع هاتفك بشكل مسطح📱";

const kEnTips = 'Tips for better qibla accuracy:\n'
    '♾️\tCalibrate compass by moving device in an 8-figure\n'
    '🧲\tMove away from electronic devices\n'
    '📱\tLay your device flat';

const kArPermissionErr = '⚠️\nالرجاء إعطاء هذا التطبيق صلاحيات الموقع "أثناء الأستخدام" لمعرفة القبلة';
const kEnPermissionErr = "⚠️\nPlease allow this app 'While using the app' location privileges to "
    "determine qibla";

const kArLocationServicesErr = "⚠️\nالرجاء تفعيل خدمات الموقع من الإعدادات لمعرفة القبلة";
const kEnLocationServicesErr = "⚠️\nPlease enable location services from your device's setting to determine qibla";

const kArAmbiguousErr = "⚠️\nعذراً، حدث خطأ في تحديد القبلة، الرجاء إعادة تشغيل التطيبق";
const kEnAmbiguousErr = "⚠️\nSorry, an error has occur please restart the app";

const kErrText = Text(kEnAmbiguousErr, style: kErrTextStyle, textAlign: TextAlign.center);
