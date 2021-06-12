import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:steps_tracker/models/user_model.dart';

class LeaderBoardController extends ControllerMVC
{
    GlobalKey<ScaffoldState> scaffoldKey;
    List<AppUser> users;
    LeaderBoardController()
    {
        this.scaffoldKey = GlobalKey<ScaffoldState>();
        init();
    }

    Future<void> init() async
    {
        setState((){
            users = [];
            users = null;
        });
        users = await AppUser.listenForLeaderBoard();
        setState((){});
    }

}