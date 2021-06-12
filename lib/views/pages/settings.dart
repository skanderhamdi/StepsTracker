import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:steps_tracker/controllers/settings_controller.dart';
import 'package:steps_tracker/helpers/helper_class.dart';
import 'package:steps_tracker/localization/language_constants.dart';
import 'package:steps_tracker/session/hive_box_manager.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends StateMVC<SettingsPage> {

  SettingsController _con;

  _SettingsPageState(): super(SettingsController())
  {
      _con = controller;
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: null,
      body: SafeArea(
        left: false,
        right: false,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getTranslated(context,"settings"),style: Theme.of(context).textTheme.headline4.copyWith(fontWeight: FontWeight.w900,color: Theme.of(context).colorScheme.primary),),
                          SizedBox(height: 6,),
                          Text(getTranslated(context,"change_app_settings"),style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w100,color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),),
                        ],
                      ),
                    ),
                    SizedBox(height: 35,),
                    buildDarkModeSection(context),
                    SizedBox(height: 30,),
                    buildLanguageSection(context)
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget buildDarkModeSection(BuildContext context)
  {
      return Column(
        children: [
          Divider(height: 1,color: Theme.of(context).colorScheme.primary.withOpacity(0.15),),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.03),
            ),
            child: Row(
              children: [
                  Expanded(
                    child: Text(getTranslated(context,"dark_mode"),style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),),
                  ),
                  IconButton(
                    onPressed: ()
                    {
                      if(getDarkMode()) _con.setMode(false);
                      else _con.setMode(true);
                    },
                    icon: Icon(!getDarkMode() ? Icons.brightness_2 : Icons.wb_sunny),
                  )
              ],
            ),
          ),
          Divider(height: 1,color: Theme.of(context).colorScheme.primary.withOpacity(0.15),),
        ],
      );
  }

  Widget buildLanguageSection(BuildContext context)
  {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 1,color: Theme.of(context).colorScheme.primary.withOpacity(0.15),),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.03),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(getTranslated(context,"app_language"),style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),),
                    SizedBox(height: 6,),
                    Text(getTranslated(context,"app_language_caption"),style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w100,color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),),
                    SizedBox(height: 20,),
                    FutureBuilder<Locale>(
                      future: _con.initLocale(),
                      builder: (context,snapshot)
                      {
                            if(!snapshot.hasData)
                              return Row(
                                children: [
                                  Helper.sizedCircularProgressIndicator(width: 10,height: 10,color: Theme.of(context).colorScheme.primary.withOpacity(0.2),strokeWidth: 1),
                                  SizedBox(width: 10,),
                                  Text(getTranslated(context,"loading_languages"),style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 10,fontWeight: FontWeight.w100,color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),),
                                ],
                              );
                            else
                              return Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () => _con.setAppLanguage("en"),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 25),
                                        decoration: BoxDecoration(
                                            color: snapshot.data.languageCode == "en" ? Theme.of(context).colorScheme.primaryVariant : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(3)
                                        ),
                                        child: Center(child: Text(getTranslated(context,"english"),style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold,color: snapshot.data.languageCode == "en" ? Colors.white : Theme.of(context).colorScheme.primary),)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () => _con.setAppLanguage("ar"),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 25),
                                        decoration: BoxDecoration(
                                            color: snapshot.data.languageCode == "ar" ? Theme.of(context).colorScheme.primaryVariant : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(3)
                                        ),
                                        child: Center(child: Text(getTranslated(context,"arabic"),style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold,color: snapshot.data.languageCode == "ar" ? Colors.white : Theme.of(context).colorScheme.primary),)),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1,color: Theme.of(context).colorScheme.primary.withOpacity(0.15),),
      ],
    );
  }

}