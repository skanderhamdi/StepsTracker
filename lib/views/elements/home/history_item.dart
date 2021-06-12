import 'package:flutter/material.dart';
import 'package:steps_tracker/localization/language_constants.dart';
import 'package:steps_tracker/models/date_steps_model.dart';

// ignore: must_be_immutable
class HistoryItem extends StatelessWidget {
  DateSteps dateStep;
  HistoryItem(this.dateStep);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Row(
            children: [
              Opacity(opacity: 0.4,child: Text(dateStep.date,style: Theme.of(context).textTheme.bodyText1,),),
              SizedBox(width: 4,),
              Opacity(opacity: 0.4,child: Text(".",style: Theme.of(context).textTheme.bodyText1,),),
              SizedBox(width: 4,),
              Text(dateStep.stepsCount.toString()+" "+getTranslated(context,"steps"),style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w600),),
            ],
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 50,
            maxWidth: 60
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryVariant,
                borderRadius: BorderRadius.circular(2)
            ),
            child: Center(child: Text("+"+dateStep.healthPoints.toString(),style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white,fontWeight: FontWeight.w700),)),
          ),
        )
      ],
    );
  }
}
