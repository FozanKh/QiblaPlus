import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:qibla_plus/model/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Lang { en, ar }

class LogicController extends ChangeNotifier {
  Lang currLang;
  String langString;
  Alignment tipsAlignment;
  TextAlign tipsTextAlignment;
  String tips;
  SharedPreferences localData;
  String needleAsset = 'images/Needle.png';
  Color isExact = kTransparent;

  //TODO: Add sharedPreference, and handle language properly

  getCurrLang() async {
    print('getCurrLang');
    localData = await SharedPreferences.getInstance();
    print(localData.get('language'));
    if (localData.get('language') != null)
      currLang = (localData.get('language') == Lang.ar.toString()) ? Lang.ar : Lang.en;
    else {
      currLang = (ui.window.locale.languageCode == 'ar') ? Lang.ar : Lang.en;
      localData.setString('language', currLang.toString());
    }
  }

  updateLang() {
    currLang = (currLang == Lang.ar) ? Lang.en : Lang.ar;
    localData.setString('language', currLang.toString());
    langString = (currLang == Lang.ar) ? kEnLangString : kArLangString;
    tipsAlignment = (currLang == Lang.ar) ? Alignment.centerRight : Alignment.centerLeft;
    tipsTextAlignment = (currLang == Lang.ar) ? TextAlign.right : TextAlign.left;
    tips = (currLang == Lang.ar) ? kArTips : kEnTibs;
  }

  //TODO: language
  //TODO: tips
  Future<void> setUpLang() async {
    print('setUpLang');
    await getCurrLang();
    print('setUpLangDone');
    langString = (currLang == Lang.ar) ? kEnLangString : kArLangString;
    tipsAlignment = (currLang == Lang.ar) ? Alignment.centerRight : Alignment.centerLeft;
    tipsTextAlignment = (currLang == Lang.ar) ? TextAlign.right : TextAlign.left;
    tips = (currLang == Lang.ar) ? kArTips : kEnTibs;
  }

  //TODO: last calibration
  //TODO: must calibrate

}
