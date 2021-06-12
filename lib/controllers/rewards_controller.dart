import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:steps_tracker/models/reward_model.dart';

class RewardsController extends ControllerMVC
{
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Reward> rewards;
  bool wait = false;

  RewardsController()
  {
      this.scaffoldKey = GlobalKey<ScaffoldState>();
      init();
  }

  Future<void> init() async
  {
      setState((){
        rewards = [];
        rewards = null;
      });
      rewards = await Reward.listenForRewards();
      setState((){});
  }

  void setWait()
  {
      setState((){
        wait = !wait;
      });
  }

  Future<bool> exchangePoints(Reward reward) async
  {
      return await Reward.exchangePoints(reward);
  }

}
