import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:qibla_plus/model/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Lang { en, ar }

class LogicController {
  Lang currLang;
  String langString;
  Alignment tipsAlignment;
  TextAlign tipsTextAlignment;
  String tips;
  String permissionErr;
  String locationServicesErr;
  String ambiguousErr;
  SharedPreferences localData;
  String needleAsset = 'images/Needle.png';
  Color isExact = kTransparent;

  Future<void> setUpLang() async {
    print('setUpLang');
    await getCurrLang();
    print('setUpLangDone');
    langString = (currLang == Lang.ar) ? kEnLangString : kArLangString;
    tipsAlignment = (currLang == Lang.ar) ? Alignment.centerRight : Alignment.centerLeft;
    tipsTextAlignment = (currLang == Lang.ar) ? TextAlign.right : TextAlign.left;
    tips = (currLang == Lang.ar) ? kArTips : kEnTibs;
    permissionErr = (currLang == Lang.ar) ? kArPermissionErr : kEnPermissionErr;
    locationServicesErr = (currLang == Lang.ar) ? kArLocationServicesErr : kEnLocationServicesErr;
    ambiguousErr = (currLang == Lang.ar) ? kArAmbiguousErr : kEnAmbiguousErr;
  }

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
    permissionErr = (currLang == Lang.ar) ? kArPermissionErr : kEnPermissionErr;
    locationServicesErr = (currLang == Lang.ar) ? kArLocationServicesErr : kEnLocationServicesErr;
    ambiguousErr = (currLang == Lang.ar) ? kArAmbiguousErr : kEnAmbiguousErr;
  }

  //TODO: last calibration
  //TODO: must calibrate

}
