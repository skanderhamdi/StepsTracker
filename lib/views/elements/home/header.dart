import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:steps_tracker/helpers/global.dart' as Global;
import 'package:steps_tracker/localization/language_constants.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(getTranslated(context,"steps_tracker"),style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.w900,color: Theme.of(context).colorScheme.primary),),
                SizedBox(height: 6,),
                Text(getTranslated(context,"hello")+Global.auth.currentUser.displayName,style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w100,color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),),
              ],
            ),
            Global.auth.currentUser.photoURL == null
                ? ClipRRect(child: Image.asset("assets/images/default_user.png", width: 45,height: 45,),borderRadius: BorderRadius.circular(100),)
                : ClipRRect(child: CachedNetworkImage(imageUrl: Global.auth.currentUser.photoURL,width: 45,height: 45,fit: BoxFit.cover,),borderRadius: BorderRadius.circular(100),)
          ],
        )
    );
  }
}
