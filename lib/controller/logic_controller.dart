import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:qibla_plus/model/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qibla_plus/model/components/tips.dart' as Tips;
import 'package:qibla_plus/model/components/title.dart' as Title;

enum Lang { en, ar }

class LogicController {
  Lang currLang;
  String langString;
  Alignment tipsAlignment;
  TextAlign tipsTextAlignment;
  Widget tips;
  String permissionErr;
  String locationServicesErr;
  String loadingMessage;
  String ambiguousErr;
  Widget title;
  SharedPreferences localData;
  String needleAsset = 'assets/images/Needle.png';
  Color isExact = kTransparent;

  Future<void> setUpLang() async {
    await getCurrLang();
    langString = (currLang == Lang.ar) ? kEnLangString : kArLangString;
    tips = (currLang == Lang.ar) ? Tips.ArabicTips() : Tips.EnglishTips();
    title = (currLang == Lang.ar) ? Title.ArabicTitle() : Title.EnglishTitle();
    permissionErr = (currLang == Lang.ar) ? kArPermissionErr : kEnPermissionErr;
    locationServicesErr = (currLang == Lang.ar) ? kArLocationServicesErr : kEnLocationServicesErr;
    loadingMessage = (currLang == Lang.ar) ? kArLoadingMessage : kEnLoadingMessage;
    ambiguousErr = (currLang == Lang.ar) ? kArAmbiguousErr : kEnAmbiguousErr;
  }

  void updateLang() {
    currLang = (currLang == Lang.ar) ? Lang.en : Lang.ar;
    localData.setString('language', currLang.toString());
    langString = (currLang == Lang.ar) ? kEnLangString : kArLangString;
    tips = (currLang == Lang.ar) ? Tips.ArabicTips() : Tips.EnglishTips();
    title = (currLang == Lang.ar) ? Title.ArabicTitle() : Title.EnglishTitle();
    permissionErr = (currLang == Lang.ar) ? kArPermissionErr : kEnPermissionErr;
    locationServicesErr = (currLang == Lang.ar) ? kArLocationServicesErr : kEnLocationServicesErr;
    loadingMessage = (currLang == Lang.ar) ? kArLoadingMessage : kEnLoadingMessage;
    ambiguousErr = (currLang == Lang.ar) ? kArAmbiguousErr : kEnAmbiguousErr;
  }

  Future<void> getCurrLang() async {
    localData = await SharedPreferences.getInstance();
    if (localData.get('language') != null)
      currLang = (localData.get('language') == Lang.ar.toString()) ? Lang.ar : Lang.en;
    else {
      currLang = (ui.window.locale.languageCode == 'ar') ? Lang.ar : Lang.en;
      localData.setString('language', currLang.toString());
    }
  }
}
