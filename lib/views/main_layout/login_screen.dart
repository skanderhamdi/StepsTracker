import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:steps_tracker/controllers/login_controller.dart';
import 'package:steps_tracker/helpers/expandable_page_view.dart';
import 'package:steps_tracker/helpers/helper_class.dart';
import 'package:steps_tracker/localization/language_constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends StateMVC<LoginScreen> {

  LoginController _con;

  _LoginScreenState(): super(LoginController())
  {
      _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
            key: _con.scaffoldKey,
            backgroundColor: Colors.white,
            appBar: null,
            body: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Center(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: SafeArea(
                          left: false,
                          right: false,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 25),
                                      child: Image.asset("assets/logo/logo_white.png",width: width/4,fit: BoxFit.fitWidth,),
                                    ),
                                    SizedBox(height: 20,),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 35),
                                      child: Text(getTranslated(context,"welcome"),style: Theme.of(context).textTheme.headline4.copyWith(fontWeight: FontWeight.w900,color: Color(0xff303030)),),
                                    ),
                                    SizedBox(height: 6,),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 35),
                                      child: Text(getTranslated(context,"login_caption"),style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w100,color: Color(0xff303030).withOpacity(0.4)),),
                                    ),
                                    SizedBox(height: 20,),
                                    Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 35),
                                        child: ExpandablePageView(
                                          physics: NeverScrollableScrollPhysics(),
                                          controller: _con.pController,
                                          children: [
                                            buildPseudoNameTextField(context),
                                            buildProfilePictureContainer(context)
                                          ],
                                        )
                                    ),
                                    SizedBox(height: 50,),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: Column(
                                          children: [
                                            FlatButton(
                                              child: Icon(Icons.arrow_forward_rounded,color: Colors.white,),
                                              disabledColor: Color(0xff303030).withOpacity(0.2),
                                              splashColor: Color(0xff303030).withOpacity(0.3),
                                              color: Color(0xff303030),
                                              padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    bottomLeft: Radius.circular(5),
                                                  )
                                              ),
                                              onPressed: _con.pseudoNameController.text.length == 0 ? null : () async
                                              {
                                                if(_con.currentIndex==0)
                                                {
                                                  await _con.signIn();
                                                }else{
                                                  await _con.finishSignIn();
                                                }
                                              },
                                            ),
                                            SizedBox(height: 15,),
                                            DotsIndicator(
                                              dotsCount: 2,
                                              position: _con.currentIndex.toDouble(),
                                              decorator: DotsDecorator(
                                                  spacing: EdgeInsets.symmetric(horizontal: 3),
                                                  color: Color(0xff303030).withOpacity(0.3),
                                                  activeColor: Color(0xff303030)
                                              ),
                                            )
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ),
                Padding(
                    padding: EdgeInsets.all(35),
                    child: Row(
                      children: [
                        Image.asset("assets/logo/logo_white.png",width: width*0.07, fit: BoxFit.fitWidth,),
                        SizedBox(width: 8,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(getTranslated(context,"steps_tracker"),style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold,color: Color(0xff303030)),),
                            Text(getTranslated(context,"copyrights"),style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 10,fontWeight: FontWeight.w100,color: Color(0xff303030).withOpacity(0.3)),),
                          ],
                        )
                      ],
                    )
                )
              ],
            )
        ),
        if(_con.wait) Container(
          width:  width,
          height: height,
          color: Colors.black.withOpacity(0.5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Helper.sizedCircularProgressIndicator(width: 20,height: 20,color: Colors.white.withOpacity(0.7),strokeWidth: 1.5),
                    SizedBox(height: 10,),
                    Text(getTranslated(context,"please_wait"),style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w100,color: Colors.white.withOpacity(0.7)),),
                  ],
                ),
              )
            ],
          )
        )
      ],
    );
  }
  
  Widget buildPseudoNameTextField(BuildContext context)
  {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: _con.pseudoNameController,
          onChanged: (value) => setState((){}),
          keyboardType: TextInputType.text,
          cursorColor: Color(0xff303030),
          style: Theme.of(context).textTheme.subtitle1.copyWith(color: Color(0xff303030)),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            filled: true,
            fillColor: Color(0xff303030).withOpacity(0.05),
            hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w100,color: Color(0xff303030).withOpacity(0.4)),
            hintText: getTranslated(context,"login_text_field_hint"),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                color: Colors.transparent
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                color: Colors.transparent
              ),
              borderRadius: BorderRadius.circular(5)
            )
          ),
        ),
      );
  }

  Widget buildProfilePictureContainer(BuildContext context)
  {
      double width = MediaQuery.of(context).size.width;
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: Stack(
            children: <Widget>[
              Container(
                height: (width/3)+20,
                width: (width/3)+20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                    height: (width/2),
                    width: (width/2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: _con.chosenImage != null
                          ? Image.file(_con.chosenImage,fit: BoxFit.cover,)
                          : Image.asset("assets/images/default_user.png", fit: BoxFit.cover,),
                    ),
                    padding: EdgeInsets.all(5),
                    decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        border:Border.all(width:5,color: Color(0xFFC1C1C1).withOpacity(0.5))
                    )
                ),
              ),
              Positioned(
                child: GestureDetector(
                    onTap: _con.chooseImage,
                    child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: Color(0xFFDDDDDD),
                          border:Border.all(
                              color: Colors.white,
                              width: 3
                          )
                      ),
                      child: Icon(Icons.camera_alt,color: Colors.black,size: 23,),
                    )
                ),
                bottom: 0,
                right: 0,
              )
            ],
          ),
        ),
      );
  }
  
}
