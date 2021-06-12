import 'package:flutter/material.dart';
import 'package:steps_tracker/controllers/home_controller.dart';
import 'package:steps_tracker/helpers/helper_class.dart';
import 'package:steps_tracker/localization/language_constants.dart';

// ignore: must_be_immutable
class TodaySteps extends StatefulWidget {
  HomeController controller;
  TodaySteps(this.controller);
  @override
  _TodayStepsState createState() => _TodayStepsState();
}

class _TodayStepsState extends State<TodaySteps> {
  @override
  Widget build(BuildContext context) {
    return widget.controller.todaySteps != null
        ? Column(
      children: [
        Divider(height: 1,color: Theme.of(context).colorScheme.primaryVariant.withOpacity(0.3),),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryVariant.withOpacity(0.1),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getTranslated(context,"today"),style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w800,color: Theme.of(context).colorScheme.primary),),
                  Text(widget.controller.todaySteps.date,style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.w400,color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          FittedBox(
                            child: Text(
                              widget.controller.todaySteps.stepsCount.toString(),
                              style: Theme.of(context).textTheme.headline1.copyWith(fontSize: widget.controller.todaySteps.stepsCount>=10 ? 500 : 250,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(getTranslated(context,"steps"),style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold),),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 40,),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryVariant,
                      borderRadius: BorderRadius.circular(2)
                    ),
                    child: Text("+"+widget.controller.todaySteps.healthPoints.toString(),style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white,fontWeight: FontWeight.w700),),
                  )
                ],
              ),
            ],
          ),
        ),
        Divider(height: 1,color: Theme.of(context).colorScheme.primaryVariant.withOpacity(0.3),),
      ],
    )
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 30,horizontal: 35),
            child: Row(
              children: [
                Helper.sizedCircularProgressIndicator(width: 15,height: 15,strokeWidth: 1.5,color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                SizedBox(width: 15,),
                Text(getTranslated(context,"please_wait"),style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w100,color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),),
              ],
            )
          );
  }
}
