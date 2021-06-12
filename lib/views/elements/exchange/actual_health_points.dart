import 'package:flutter/material.dart';
import 'package:steps_tracker/controllers/exchange_controller.dart';
import 'package:steps_tracker/localization/language_constants.dart';
import 'package:steps_tracker/helpers/global.dart' as Global;
import 'package:steps_tracker/views/pages/rewards.dart';

// ignore: must_be_immutable
class ActualHealthPoints extends StatefulWidget {
  bool seeRewards;
  ExchangeController exchangeController;
  ActualHealthPoints(this.seeRewards,{this.exchangeController});
  @override
  _ActualHealthPointsState createState() => _ActualHealthPointsState();
}

class _ActualHealthPointsState extends State<ActualHealthPoints> {
  @override
  Widget build(BuildContext context) {
    final TextDirection currentDirection = Directionality.of(context);
    final bool isRTL = currentDirection == TextDirection.rtl;
    return Column(
      children: [
        Divider(height: 1,color: Theme.of(context).colorScheme.primaryVariant.withOpacity(0.3),),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 25),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryVariant.withOpacity(0.05),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getTranslated(context,"actual_points"),style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w900,color: Theme.of(context).colorScheme.primary),),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: Global.currentHealthPoints,
                      builder: (context,value,_){
                        return Text(Global.currentHealthPoints.value.toString()+" "+getTranslated(context,"pts"),style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.w900,color: Theme.of(context).colorScheme.primaryVariant),textAlign: TextAlign.end,);
                      },
                    )
                  ),
                ],
              ),
              if(widget.seeRewards) SizedBox(height: 30,),
              if(widget.seeRewards) FlatButton(
                onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => RewardsPage(exchangeController:widget.exchangeController) ));
                },
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                color: Theme.of(context).colorScheme.primaryVariant,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_forward_ios_rounded,color: Colors.transparent,size: 18,),
                    Text(getTranslated(context,"see_rewards_list"),style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600,color: Colors.white),),
                    Icon(isRTL ? Icons.arrow_back_ios_rounded : Icons.arrow_forward_ios_rounded,color: Colors.white,size: 18,),
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(height: 1,color: Theme.of(context).colorScheme.primaryVariant.withOpacity(0.3),),
      ],
    );
  }
}
