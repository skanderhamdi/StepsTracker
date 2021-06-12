import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:steps_tracker/controllers/exchange_controller.dart';
import 'package:steps_tracker/controllers/rewards_controller.dart';
import 'package:steps_tracker/helpers/helper_class.dart';
import 'package:steps_tracker/localization/language_constants.dart';
import 'package:steps_tracker/views/elements/exchange/actual_health_points.dart';
import 'package:steps_tracker/views/elements/exchange/partners_header.dart';
import 'package:steps_tracker/views/elements/exchange/rewards_list.dart';

// ignore: must_be_immutable
class RewardsPage extends StatefulWidget {
  ExchangeController exchangeController;
  RewardsPage({this.exchangeController});
  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends StateMVC<RewardsPage> {

  RewardsController _con;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  _RewardsPageState(): super(RewardsController())
  {
      _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
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
                                  Text(getTranslated(context,"health_points_exchange"),style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.w900,color: Theme.of(context).colorScheme.primary),),
                                  SizedBox(height: 6,),
                                  Text(getTranslated(context,"health_points_exchange_caption"),style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w100,color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),),
                                ],
                              ),
                            ),
                            SizedBox(height: 35,),
                            ActualHealthPoints(false),
                            SizedBox(height: 30,),
                            PartnersHeader(),
                            SizedBox(height: 25,),
                            RewardsList(_con,exchangeController:widget.exchangeController)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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

  Future<void> refresh() async
  {
    await _con.init();
    _refreshController.refreshCompleted();
  }
}
