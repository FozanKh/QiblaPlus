import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kKabbahLat = 0.3738927226761722; //21.4224750 deg
const kKabbahLon = 0.6950985611585316; //39.8262139 deg
const kTransparent = Colors.transparent;
const kLightBlue = Color(0xff263a4c);
const kDarkBlue = Color(0xff4b7aa1);
const kGradientBackground = BoxDecoration(gradient: LinearGradient(colors: [kDarkBlue, kLightBlue], begin: Alignment.topRight, end: Alignment.bottomLeft));

const kTitleTextStyle = TextStyle(fontSize: 40, color: Colors.white, fontFamily: 'Tajawal');

const kEnTipsTextStyle = TextStyle(color: Colors.white, letterSpacing: 0.2, fontFamily: 'Tajawal', height: 1.5);
const kArTipsTextStyle = TextStyle(color: Colors.white, letterSpacing: 1.5, fontFamily: 'Tajawal', height: 1.5);

const kErrTextStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.w600, height: 1.5);

//Language Strings--------------------------------------------------------------------------------
const kArLangString = 'عــربــي';
const kEnLangString = 'English';

const kEnTitle = 'Qibla +';
const kArTitle = '+ قبلة';

const kEnTips = 'Tips for better qibla accuracy:\n'
    '✅\tCalibrate compass by moving device in an 8-figure\n'
    '🧲\tMove away from electronic devices\n'
    '📱\tLay your device flat';

const kArTips = ': نصائح لقبلة أدق'
    '\nعاير البوصلة بتدوير الجهاز على شكل الرقم 8 ✅'
    '\nابتعد عن الأجهزة الإلكترونية 🧲'
    '\nضع هاتفك بشكل مسطح 📱';

const kEnCalib1 = 'Please calibrate your compass\n';
const kEnCalib2 = 'by moving your device as shown below\n';
const kArCalib1 = 'الرجاء معايرة البوصلة\n';
const kArCalib2 = 'بتحريك جهازك كما في الشكل الموضح\n';

const kArPermissionErr = '⚠️\nالرجاء إعطاء هذا التطبيق صلاحيات الموقع "أثناء الأستخدام" لمعرفة القبلة';
const kEnPermissionErr = "⚠️\nPlease allow this app 'While using the app' location privileges";

const kArLocationServicesErr = "⚠️\nالرجاء تفعيل خدمات الموقع من الإعدادات لمعرفة القبلة";
const kEnLocationServicesErr = "⚠️\nPlease enable location services from your device's setting";

const kArAmbiguousErr = "⚠️\nعذراً، حدث خطأ في تحديد القبلة، الرجاء إعادة تشغيل التطيبق";
const kEnAmbiguousErr = "⚠️\nSorry, an error has occur please restart the app";

const kErrText = Text(kEnAmbiguousErr, style: kErrTextStyle, textAlign: TextAlign.center);
