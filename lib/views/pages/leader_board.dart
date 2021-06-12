import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:steps_tracker/controllers/leaderboard_controller.dart';
import 'package:steps_tracker/localization/language_constants.dart';
import 'package:steps_tracker/views/elements/leaderboard/leaderboard_list.dart';

class LeaderBoardPage extends StatefulWidget {
  @override
  _LeaderBoardPageState createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends StateMVC<LeaderBoardPage> {

  LeaderBoardController _con;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  _LeaderBoardPageState(): super(LeaderBoardController())
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
                  child: SmartRefresher(
                    controller: _refreshController,
                    onRefresh: ()=> refresh(),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(getTranslated(context,"loader_board"),style: Theme.of(context).textTheme.headline4.copyWith(fontWeight: FontWeight.w900,color: Theme.of(context).colorScheme.primary),),
                                SizedBox(height: 6,),
                                Text(getTranslated(context,"loader_board_caption"),style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w100,color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),),
                              ],
                            ),
                          ),
                          SizedBox(height: 35,),
                          LeaderBoardList(_con),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      );
  }

  Future<void> refresh() async
  {
      await _con.init();
      _refreshController.refreshCompleted();
  }

}
