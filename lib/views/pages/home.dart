import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:steps_tracker/controllers/home_controller.dart';
import 'package:steps_tracker/views/elements/home/header.dart';
import 'package:steps_tracker/views/elements/home/history_header.dart';
import 'package:steps_tracker/views/elements/home/history_list.dart';
import 'package:steps_tracker/views/elements/home/today_steps.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateMVC<HomePage> {

  HomeController _con;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  _HomePageState(): super(HomeController()){
      _con = controller;
  }

  @override
  Widget build(BuildContext context) {
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
              child: SmartRefresher(
                controller: _refreshController,
                onRefresh: ()=> refresh(),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeHeader(),
                      SizedBox(height: 35,),
                      TodaySteps(_con),
                      SizedBox(height: 30,),
                      HistoryHeader(_con),
                      SizedBox(height: 25,),
                      HistoryList(_con),
                      /*Offstage(
                        offstage: !_con.showChart,
                        child: HistoryChart(_con),
                      )*/
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> refresh() async
  {
      await _con.init();
      _refreshController.refreshCompleted();
  }

}
