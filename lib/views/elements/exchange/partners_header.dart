import 'package:flutter/material.dart';
import 'package:steps_tracker/localization/language_constants.dart';

class PartnersHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(getTranslated(context,"partners"),style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w900,color: Theme.of(context).colorScheme.primary),),
          SizedBox(height: 6,),
          Text(getTranslated(context,"partners_caption"),style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w100,color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),),
        ],
      ),
    );
  }
}
