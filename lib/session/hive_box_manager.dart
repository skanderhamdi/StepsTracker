import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Box localData;
Box<int> stepsBox;

Future openBox() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  localData = await Hive.openBox('session');
  stepsBox = await Hive.openBox('steps');
  return;
}

/* Dark Mode */

void setDarkMode(bool dark) async
{
    localData.put("dark_mode",dark);
}

bool getDarkMode()
{
    return localData.get("dark_mode") == null ? false : localData.get("dark_mode");
}