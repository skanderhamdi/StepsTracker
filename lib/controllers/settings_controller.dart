import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:steps_tracker/localization/language_constants.dart';
import 'package:steps_tracker/main.dart';
import 'package:steps_tracker/session/hive_box_manager.dart';

class SettingsController extends ControllerMVC
{
    GlobalKey<ScaffoldState> scaffoldKey;
    Locale currentLocale;
    SettingsController()
    {
        this.scaffoldKey = GlobalKey<ScaffoldState>();
        initLocale();
    }

    Future<Locale> initLocale() async
    {
        currentLocale = await getLocale();
        return currentLocale;
    }

    void setMode(bool dark)
    {
        if (dark)
        {
            setDarkMode(true);
            App.of(this.scaffoldKey.currentState.context).changeTheme(ThemeMode.dark);
        }
        else{
            setDarkMode(false);
            App.of(this.scaffoldKey.currentState.context).changeTheme(ThemeMode.light);
        }
    }

    void setAppLanguage(String lang)
    {
        setLocale(lang).then((value){
            App.setLocale(scaffoldKey.currentState.context,value);
        });
    }
}