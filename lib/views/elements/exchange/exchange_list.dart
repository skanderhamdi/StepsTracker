import 'package:flutter/material.dart';
import 'package:steps_tracker/controllers/exchange_controller.dart';
import 'package:steps_tracker/helpers/helper_class.dart';
import 'package:steps_tracker/localization/language_constants.dart';
import 'package:steps_tracker/views/elements/exchange/exchange_item.dart';

// ignore: must_be_immutable
class ExchangeList extends StatefulWidget {
  ExchangeController controller;
  ExchangeList(this.controller);
  @override
  _ExchangeListState createState() => _ExchangeListState();
}

class _ExchangeListState extends State<ExchangeList> {
  @override
  Widget build(BuildContext context) {
    return widget.controller.exchanges == null
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
        : widget.controller.exchanges.length == 0
          ? Padding(
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 35),
        child: Center(child: Text(getTranslated(context,"no_data"),style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w100,color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),)),
      )
          :ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 30),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.controller.exchanges.length,
        itemBuilder: (context,index)
        {
            return ExchangeItem(widget.controller.exchanges[index]);
        },
        separatorBuilder: (context,index){
            return SizedBox(height: 15,);
        },
      );
  }
}
