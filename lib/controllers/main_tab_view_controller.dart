import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class MainTabViewController extends ControllerMVC
{
    GlobalKey<ScaffoldState> scaffoldKey;
    int currentIndex = 1;
    MainTabViewController()
    {
        this.scaffoldKey = GlobalKey<ScaffoldState>();
    }
    void updateIndex(int index){
        setState(() {
            currentIndex = index;
        });
    }
}