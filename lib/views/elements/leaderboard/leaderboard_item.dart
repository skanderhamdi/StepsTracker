import 'package:flutter/material.dart';
import 'package:steps_tracker/localization/language_constants.dart';
import 'package:steps_tracker/helpers/global.dart' as Global;
import 'package:steps_tracker/models/user_model.dart';

// ignore: must_be_immutable
class LeaderBoardItem extends StatelessWidget {
  AppUser user;
  int index;
  LeaderBoardItem(this.user,this.index);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: 40,
                    maxWidth: 70
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                  decoration: BoxDecoration(
                      color: user.uid == Global.auth.currentUser.uid ? Theme.of(context).colorScheme.primaryVariant : Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(2)
                  ),
                  child: Text(index.toString(),style: Theme.of(context).textTheme.bodyText1.copyWith(color: user.uid == Global.auth.currentUser.uid ? Colors.white : Theme.of(context).colorScheme.surface ,fontWeight: FontWeight.w900),textAlign: TextAlign.center,),
                ),
              ),
              SizedBox(width: 15,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.pseudoName,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w400,color: Theme.of(context).colorScheme.primary),),
                  /*SizedBox(width: 4,),
                  Text(
                    ".",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w400,color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),),
                  SizedBox(width: 4,),
                  Text(
                    user.signUpDate,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w400,color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),),*/
                ],
              )
            ],
          ),
        ),
        Row(
          children: [
            Text(user.totalStepsCount.toString(),style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.w900,color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),),
            SizedBox(width: 3,),
            Text(getTranslated(context,"steps"),style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),),
          ],
        )
      ],
    );
  }
}
