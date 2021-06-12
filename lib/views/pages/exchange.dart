import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:steps_tracker/controllers/exchange_controller.dart';
import 'package:steps_tracker/localization/language_constants.dart';
import 'package:steps_tracker/views/elements/exchange/actual_health_points.dart';
import 'package:steps_tracker/views/elements/exchange/exchange_list.dart';
import 'package:steps_tracker/views/elements/exchange/history_header.dart';

class ExchangePage extends StatefulWidget {
  @override
  _ExchangePageState createState() => _ExchangePageState();
}

class _ExchangePageState extends StateMVC<ExchangePage> {

  ExchangeController _con;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  _ExchangePageState(): super(ExchangeController())
  {
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(getTranslated(context,"health_points_exchange"),style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.w900,color: Theme.of(context).colorScheme.primary),),
                              SizedBox(height: 6,),
                              Text(getTranslated(context,"health_points_exchange_caption"),style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w100,color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),),
                            ],
                          ),
                        ),
                        SizedBox(height: 35,),
                        ActualHealthPoints(true,exchangeController:_con),
                        SizedBox(height: 30,),
                        HistoryHeader(),
                        SizedBox(height: 25,),
                        ExchangeList(_con)
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
