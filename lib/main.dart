import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:steps_tracker/custom_router.dart';
import 'package:steps_tracker/localization/demo_localization.dart';
import 'package:steps_tracker/localization/language_constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:steps_tracker/notification_service/notification_services.dart';
import 'package:steps_tracker/session/hive_box_manager.dart';
import 'package:steps_tracker/helpers/global.dart' as Global;

void main() async
{
    await openBox();
    await Firebase.initializeApp();
    await NotificationService().init();
    runApp(App());
}

class App extends StatefulWidget {

  const App({Key key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale)
  {
      _AppState state = context.findAncestorStateOfType<_AppState>();
      state.setLocale(newLocale);
  }
  static _AppState of(BuildContext context) => context.findAncestorStateOfType<_AppState>();
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  static ThemeMode _themeMode = ThemeMode.system;
  static Locale _locale;

  static final androidMethodChannel = "foreground.service/steps_tracker_service";

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  void initState()
  {
      WidgetsBinding.instance.addObserver(this);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      bool isDark = getDarkMode();
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      super.initState();
  }

  void didUpdateWidget(covariant App oldWidget)
  {
    setState((){});
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Global.appState = state;
    switch (state) {
      case AppLifecycleState.resumed:
        if(Global.auth.currentUser?.uid!=null) stopService();
        break;
      case AppLifecycleState.paused:
        if(Global.auth.currentUser?.uid!=null) startService();
        break;
      case AppLifecycleState.detached:
        if(Global.auth.currentUser?.uid!=null) stopService();
        break;
      default:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  /* Foreground Service */
  void startService() async
  {
      if(Platform.isAndroid)
      {
        try{
          Map<String,String> dataChannel = {
            "title":"StepsTracker",
            "subTitle":"Service StepsTracker is running on the background",
            "subText":"Consider keeping to app alive",
          };
          var methodChannel = MethodChannel(androidMethodChannel);
          bool data = await methodChannel.invokeMethod("startService",dataChannel);
          if(data){
            print("Start Service Done");
          }else{
            print("Failed to start Service");
          }
        } on PlatformException catch(e){
          print("PlateformException: "+e.message);
        } catch(e){
          print("Exception: "+e.message);
        }
      }
      if(Platform.isIOS)
      {
        // Not yet
      }
  }

  void stopService() async
  {
      if(Platform.isAndroid)
      {
        try{
          var methodChannel = MethodChannel(androidMethodChannel);
          bool data = await methodChannel.invokeMethod("stopService",{});
          if(data){
            print("Done");
          }else{
            print("Failed");
          }
        } on PlatformException catch(e){
          print("PlateformException: "+e.message);
        } catch(e){
          print("Exception: "+e.message);
        }
      }
      if(Platform.isIOS)
      {
        // Not yet
      }
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  void changeTheme(ThemeMode themeMode)
  {
      setState(() {
        _themeMode = themeMode;
      });
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800])),
        ),
      );
    } else {
      return MaterialApp(
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: GoogleFonts.latoTextTheme().subtitle1.fontFamily,
          /*textTheme: TextTheme(
            headline5: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black),
            headline4: Theme.of(context).textTheme.headline4.copyWith(color: Colors.black),
            headline3: Theme.of(context).textTheme.headline3.copyWith(color: Colors.black),
            headline2: Theme.of(context).textTheme.headline2.copyWith(color: Colors.black),
            headline1: Theme.of(context).textTheme.headline1.copyWith(color: Colors.black),
          ),*/
          colorScheme: ColorScheme(
            primary: Colors.black,
            primaryVariant: Colors.green,
            secondary: Colors.blue,
            secondaryVariant: Colors.white,
            error: Colors.red,
            surface: Colors.white,
            background: Colors.white,
            onPrimary: Colors.white,
            onBackground: Colors.white,
            onError: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.white,
            brightness: Brightness.light
          )
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
            fontFamily: GoogleFonts.latoTextTheme().subtitle1.fontFamily,
            /*textTheme: TextTheme(
              headline5: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
              headline4: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white),
              headline3: Theme.of(context).textTheme.headline3.copyWith(color: Colors.white),
              headline2: Theme.of(context).textTheme.headline2.copyWith(color: Colors.white),
              headline1: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white),
            ),*/
            colorScheme: ColorScheme(
                primary: Colors.white,
                primaryVariant: Colors.green,
                secondary: Colors.blue,
                secondaryVariant: Color(0xff303030),
                error: Colors.red,
                surface: Color(0xff303030),
                background: Color(0xff303030),
                onPrimary: Color(0xff303030),
                onBackground: Color(0xff303030),
                onError: Color(0xff303030),
                onSecondary: Color(0xff303030),
                onSurface: Color(0xff303030),
                brightness: Brightness.dark
            )
        ),
        themeMode: _themeMode,
        locale: _locale,
        supportedLocales: [
          Locale("en", "US"),
          Locale("ar", "SA"),
        ],
        localizationsDelegates: [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        onGenerateRoute: CustomRouter.generatedRoute,
        initialRoute: CustomRouter.splashScreen,
      );
    }
  }
}
