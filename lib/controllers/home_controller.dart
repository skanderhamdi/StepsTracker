import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:steps_tracker/helpers/helper_class.dart';
import 'package:steps_tracker/localization/language_constants.dart';
import 'package:steps_tracker/models/date_steps_model.dart';
import 'package:steps_tracker/helpers/global.dart' as Global;
import 'package:steps_tracker/notification_service/notification_services.dart';
import 'package:steps_tracker/session/hive_box_manager.dart';


class HomeController extends ControllerMVC
{

    GlobalKey<ScaffoldState> scaffoldKey;

    /* Reference for the user document */
    DocumentReference userDoc = FirebaseFirestore.instance.collection("users").doc(Global.auth.currentUser.uid);

    /* Object DateSteps in which we store the current day steps and obtained health points */
    DateSteps todaySteps;

    /* List of obtained scores per day */
    List<DateSteps> history;

    //bool showChart = false;

    /* Step count */
    Stream<StepCount> _stepCountStream;
    Stream<PedestrianStatus> _pedestrianStatusStream;
    /* Streams subscription */
    StreamSubscription _stepCountStreamSubscription;
    StreamSubscription _pedestrianStatusStreamSubscription;

    /* Local notification */
    static AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails("gain_notif","Gain points", "Gain points notification", importance: Importance.high, priority: Priority.high);
    static IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails(presentAlert: false, presentBadge: false, presentSound: false, badgeNumber: 1,);
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics,iOS: iOSPlatformChannelSpecifics);

    HomeController()
    {
        this.scaffoldKey = GlobalKey<ScaffoldState>();
        init();
    }

    /* Initialize today steps and points as well as history */
    Future<void> init() async
    {
        setState((){
            history = null;
            todaySteps = null;
        });
        DateSteps.listenForHealthPoints();
        initTodayCounter();
        setState((){});
        history = await DateSteps.listenForHistory();
        setState((){});
    }

    /*void switchShowChart()
    {
        setState((){
            showChart = !showChart;
        });
    }*/

    Future<void> initTodayCounter() async
    {
        /* Initially, we fetch today data from Firestore (if exists) */
        DateFormat formatter = DateFormat("dd-MM-yyyy");
        String formatted = formatter.format(DateTime.now());
        DocumentSnapshot todayData = await userDoc.collection("steps").doc(formatted).get();
        if(todayData.exists){
            Map<String,dynamic> retreivedData = todayData.data();
            setState((){
                todaySteps = DateSteps.fromMap(retreivedData);
            });
        }else{
            var data = {
              "date": DateFormat('dd/MM/yyyy').format(DateTime.now()),
              "steps": 0,
              "health_points":0  
            };
            userDoc.collection("steps").doc(formatted).set(data).then((value){
                setState((){
                    todaySteps = DateSteps.fromMap(data);
                });
            });
        }
        /* In case of page refresh, we cancel step counter to create it from the beginning */
        await _stepCountStreamSubscription?.cancel();
        await _pedestrianStatusStreamSubscription?.cancel();
        initPedestrianStepsCounter();
    }

    /* Steps count */
    /* This function is fired for every stream data from STEP_COUNT sensor
    * As the number of steps is cumulative from rebooting the device or re-installing the app
    * we store, in local, the last saved value for this day and finally we subtract from the total number of steps.
    *  */
    void onStepCount(StepCount event) async {
        print(event.steps);
        int savedStepsCountKey = 999999;
        int savedStepsCount = stepsBox.get(savedStepsCountKey, defaultValue: 0);
        int todayDayNo = Jiffy(DateTime.now()).dayOfYear;
        if (event.steps < savedStepsCount) {
            savedStepsCount = 0;
            stepsBox.put(savedStepsCountKey, savedStepsCount);
        }
        int lastDaySavedKey = 888888;
        int lastDaySaved = stepsBox.get(lastDaySavedKey, defaultValue: 0);
        if (lastDaySaved < todayDayNo) {
            lastDaySaved = todayDayNo;
            savedStepsCount = event.steps;
            stepsBox..put(lastDaySavedKey, lastDaySaved)..put(savedStepsCountKey, savedStepsCount);
        }
        int steps = event.steps - savedStepsCount;
        stepsBox.put(todayDayNo, steps);
        print("Today's steps: "+steps.toString());
        int newHealthPoints = steps~/100;
        int oldHealthPoints = todaySteps.healthPoints;
        String formatted = DateFormat("dd-MM-yyyy").format(DateTime.now());
        var toSave = {
            "date": DateFormat('dd/MM/yyyy').format(DateTime.now()),
            "steps": steps,
            "health_points": newHealthPoints
        };
        userDoc.collection("steps").doc(formatted).set(toSave).then((value) async {
            setState((){
                todaySteps = DateSteps.fromMap(toSave);
            });
            DateSteps.updateTotal();
            if(newHealthPoints>oldHealthPoints) {
                Helper.gainHealthPoints(this.scaffoldKey.currentState.context, (newHealthPoints - oldHealthPoints).toString(), Duration(seconds: 5));
                if(Global.appState == AppLifecycleState.paused || Global.appState == AppLifecycleState.inactive)
                    /* If the app is paused or inactive and we have a new value for health points
                    * We send a local notification to the user.
                    *  */
                    await NotificationService().flutterLocalNotificationsPlugin.show(
                        12345,
                        getTranslated(this.scaffoldKey.currentState.context,"notification_from_steps_tracker"),
                        getTranslated(this.scaffoldKey.currentState.context,"you_gain")
                            +" "+(newHealthPoints - oldHealthPoints).toString()
                            +" "+getTranslated(this.scaffoldKey.currentState.context,"points")
                            +"."+getTranslated(this.scaffoldKey.currentState.context,"you_have")
                            +" "+newHealthPoints.toString()+" "+getTranslated(this.scaffoldKey.currentState.context,"pts")
                            +" "+getTranslated(this.scaffoldKey.currentState.context,"by_excluding_redemtions"),
                        platformChannelSpecifics,
                        payload: 'data'
                    );
            }
        });
    }

    void onPedestrianStatusChanged(PedestrianStatus event) {
        String status = event.status;
        DateTime timeStamp = event.timeStamp;
        print("onPedestrianStatusChanged: $status on $timeStamp");
    }

    void onPedestrianStatusError(error) {
        print("onPedestrianStatusError: $error");
    }

    void onStepCountError(error) {
        print("onStepCountError: $error");
    }

    Future<void> initPedestrianStepsCounter() async {
        if(Platform.isAndroid)
        {
            /*
            * Android request a permission to use sensors.
            * */
            PermissionStatus status = await Permission.activityRecognition.request();
            if(status == PermissionStatus.granted || status == PermissionStatus.limited)
            {
                _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
                _stepCountStream = Pedometer.stepCountStream;
                _stepCountStreamSubscription = _stepCountStream.listen(onStepCount);
                _stepCountStreamSubscription.onError(onStepCountError);
                _pedestrianStatusStreamSubscription = _pedestrianStatusStream.listen(onPedestrianStatusChanged);
                _pedestrianStatusStreamSubscription.onError(onPedestrianStatusError);
            }else{
                Helper.showError(this.scaffoldKey.currentState.context,"activity_recognition_permission_denied",Duration(seconds:10));
            }
        }else{
            _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
            _stepCountStream = Pedometer.stepCountStream;
            _stepCountStream.listen(onStepCount).onError(onStepCountError);
            _pedestrianStatusStream.listen(onPedestrianStatusChanged).onError(onPedestrianStatusError);
        }
    }
}