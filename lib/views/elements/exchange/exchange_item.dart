import 'package:flutter/material.dart';
import 'package:steps_tracker/localization/language_constants.dart';
import 'package:steps_tracker/models/exchange_model.dart';

// ignore: must_be_immutable
class ExchangeItem extends StatelessWidget {
  Exchange exchange;
  ExchangeItem(this.exchange);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(getTranslated(context,"redeemed_in")+" "+exchange.partner,
                style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w400),),
              SizedBox(width: 4,),
              Text(exchange.date,style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),),
            ],
          ),
        ),
        SizedBox(width: 10,),
        ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: 70,
              maxWidth: 70
          ),
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.circular(2)
              ),
              child: Center(child: Text("- "+exchange.points.toString(),style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white ,fontWeight: FontWeight.w900),)),
          ),
        ),
      ],
    );
  }
}
