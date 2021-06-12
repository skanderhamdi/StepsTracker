import 'package:steps_tracker/localization/demo_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

const String LAGUAGE_CODE = 'languageCode';
const String ENGLISH = 'en';
const String ARABIC = 'ar';

/* Change the stored value of language */
Future<Locale> setLocale(String languageCode) async {
  //await Hive.initFlutter();
  var box = await Hive.openBox('language');
  box.put(LAGUAGE_CODE,languageCode);
  return _locale(languageCode);
}

/* Get the stored value of language */
Future<Locale> getLocale() async {
  //await Hive.initFlutter();
  var box = await Hive.openBox('language');
  String languageCode = box.get(LAGUAGE_CODE) ?? "en";
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return Locale(ENGLISH, 'US');
    case ARABIC:
      return Locale(ARABIC, "SA");
    default:
      return Locale(ENGLISH, 'US');
  }
}

String getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context).translate(key);
}