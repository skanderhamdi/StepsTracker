import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:steps_tracker/helpers/helper_class.dart';
import 'package:steps_tracker/localization/language_constants.dart';
import 'package:steps_tracker/helpers/global.dart' as Global;
import 'package:steps_tracker/views/main_layout/login_screen.dart';
import 'package:steps_tracker/views/main_layout/main_tabview.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {

  @override void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //await Global.auth.signOut();
      User user = Global.auth.currentUser;
      Future.delayed(Duration(seconds: 2),(){
        if(user!=null) {
          if(user.uid != null) Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MainTabView()));
          else Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
        }
        else Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset("assets/logo/logo_white.png",width: width/4,fit: BoxFit.fitWidth,),
                SizedBox(height: 20,),
                Text(getTranslated(context,"steps_tracker"),style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.bold,color: Color(0xff303030)),),
                SizedBox(height: 5,),
                Text(getTranslated(context,"walk_and_gain"),style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w100,color: Color(0xff303030).withOpacity(0.3),letterSpacing: 4.5),),
                SizedBox(height: 30,),
                Helper.sizedCircularProgressIndicator(width: width*0.05,height: width*0.05,strokeWidth: 1.5,color: Color(0xff303030).withOpacity(0.2))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
