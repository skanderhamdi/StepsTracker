import 'package:flutter/material.dart';
import 'package:steps_tracker/controllers/exchange_controller.dart';
import 'package:steps_tracker/controllers/rewards_controller.dart';
import 'package:steps_tracker/helpers/helper_class.dart';
import 'package:steps_tracker/localization/language_constants.dart';
import 'package:steps_tracker/views/elements/exchange/reward_item.dart';

// ignore: must_be_immutable
class RewardsList extends StatefulWidget {
  RewardsController controller;
  ExchangeController exchangeController;
  RewardsList(this.controller,{this.exchangeController});
  @override
  _RewardsListState createState() => _RewardsListState();
}

class _RewardsListState extends State<RewardsList> {
  @override
  Widget build(BuildContext context) {
    return widget.controller.rewards == null
        ? Padding(
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 35),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Helper.sizedCircularProgressIndicator(width: 25,height: 25,strokeWidth: 1.5,color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
              //SizedBox(height: 15,),
              //Text(getTranslated(context,"please_wait"),style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w100,color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),),
            ],
          ),
        )
    )
        : widget.controller.rewards.length == 0
          ? Padding(
      padding: EdgeInsets.symmetric(vertical: 30,horizontal: 35),
      child: Center(child: Text(getTranslated(context,"no_data"),style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w100,color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),)),
    )
          : ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 30),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.controller.rewards.length,
              itemBuilder: (context,index)
              {
                  return RewardItem(widget.controller.rewards[index],exchangeController:widget.exchangeController,rewardsController:widget.controller);
              },
              separatorBuilder: (context,index){
                return SizedBox(height: 15,);
              },
            );
  }
}
