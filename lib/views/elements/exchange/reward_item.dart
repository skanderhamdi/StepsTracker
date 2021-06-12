import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:steps_tracker/controllers/exchange_controller.dart';
import 'package:steps_tracker/controllers/rewards_controller.dart';
import 'package:steps_tracker/helpers/funky_overlay.dart';
import 'package:steps_tracker/helpers/helper_class.dart';
import 'package:steps_tracker/localization/language_constants.dart';
import 'package:steps_tracker/models/reward_model.dart';
import 'package:steps_tracker/helpers/global.dart' as Global;

// ignore: must_be_immutable
class RewardItem extends StatelessWidget {
  Reward reward;
  RewardsController rewardsController;
  ExchangeController exchangeController;
  RewardItem(this.reward,{this.exchangeController,this.rewardsController});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: 60,
              maxWidth: 75
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryVariant.withOpacity(0.1),
                borderRadius: BorderRadius.circular(2)
            ),
            child: Column(
              children: [
                Text(reward.requiredPoints.toString(),style: Theme.of(context).textTheme.bodyText1.copyWith(color: Theme.of(context).colorScheme.primaryVariant ,fontWeight: FontWeight.w900),),
                SizedBox(height: 3,),
                Text(getTranslated(context,"pts"),style: Theme.of(context).textTheme.bodyText1.copyWith(color: Theme.of(context).colorScheme.primaryVariant ,fontWeight: FontWeight.w900),),
              ],
            )
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(reward.title,style: Theme.of(context).textTheme.bodyText1,),
              SizedBox(width: 4,),
              Text(reward.partner,style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.w900),),
            ],
          ),
        ),
        TextButton(
          onPressed: (){
              if(reward.requiredPoints > Global.currentHealthPoints.value)
              {
                  Helper.showError(context,"no_enough_points",Duration(seconds: 4));
              }else{
                showConfirmationDialog(context);
              }
          },
          child: Text(getTranslated(context,"redeem"),style: Theme.of(context).textTheme.subtitle2.copyWith(color: Global.currentHealthPoints.value>=reward.requiredPoints ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary.withOpacity(0.4)),),
        )
      ],
    );
  }

  void showConfirmationDialog(BuildContext context)
  {
    Widget popup = WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: FunkyOverlay(
          popup: Scaffold(
              backgroundColor: Colors.transparent,
              body: AlertDialog(
                contentPadding: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 10),
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                content: Builder(
                  builder: (contextc) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize:MainAxisSize.min,
                      children: [
                        Text(
                          getTranslated(context, "confirmation"),
                          style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height:10),
                        Text(
                          getTranslated(context, "do_you_confirm_redeem"),
                          style: Theme.of(context).textTheme.subtitle2.copyWith(color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),
                        ),
                        SizedBox(height:20),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed:()=>Navigator.of(context).pop(),
                              child: Text(
                                getTranslated(context, "cancel"),
                                style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                              ),
                            ),
                            SizedBox(width: 10,),
                            FlatButton(
                              onPressed:() async {
                                  Navigator.of(context).pop();
                                  rewardsController.setWait();
                                  await rewardsController.exchangePoints(reward).then((value){
                                      if(value)
                                      {
                                          exchangeController.init();
                                          Helper.showSuccess(context,"health_points_exchanged_to_reward_successfully",Duration(seconds: 5));
                                          showCouponCode(context);
                                      }else{
                                          Helper.showError(context,"something_went_wrong",Duration(seconds: 5));
                                      }
                                      rewardsController.setWait();
                                  });
                              },
                              child: Text(
                                getTranslated(context, "confirm"),
                                style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).colorScheme.surface),
                              ),
                              color: Theme.of(context).colorScheme.primaryVariant,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              )
          )
      ),
    );
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => popup
    );
  }

  void showCouponCode(BuildContext context)
  {
    Widget popup = WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: FunkyOverlay(
          popup: GestureDetector(
            onTap: (){

            },
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: AlertDialog(
                  contentPadding: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 10),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  content: Builder(
                    builder: (contextc) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize:MainAxisSize.min,
                        children: [
                          Text(
                            getTranslated(context, "coupon"),
                            style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                          ),
                          SizedBox(height:10),
                          Row(
                            children: [
                              Text(
                                reward.coupon,
                                style: Theme.of(context).textTheme.headline3.copyWith(color: Theme.of(context).colorScheme.primary),
                              ),
                              SizedBox(width: 15,),
                              IconButton(
                                iconSize: 30,
                                onPressed: (){
                                  Clipboard.setData(ClipboardData(text: reward.coupon));
                                  Helper.showSuccessWithoutTitle(context,"copied",Duration(seconds: 2));
                                },
                                color: Theme.of(context).colorScheme.primary,
                                icon: Icon(Icons.copy),
                              )
                            ],
                          ),
                          SizedBox(height:20),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15
                                ),
                                child: Text(
                                  getTranslated(context, "tap_to_dismiss"),
                                  style: Theme.of(context).textTheme.subtitle2.copyWith(color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
            ),
          )
      ),
    );
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => popup
    );
  }

}
