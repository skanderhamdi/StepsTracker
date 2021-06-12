import 'package:flutter/material.dart';
import 'package:steps_tracker/controllers/home_controller.dart';
import 'package:steps_tracker/helpers/helper_class.dart';
import 'package:steps_tracker/localization/language_constants.dart';
import 'package:steps_tracker/views/elements/home/history_item.dart';

// ignore: must_be_immutable
class HistoryList extends StatefulWidget {
  HomeController controller;
  HistoryList(this.controller);
  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  Widget build(BuildContext context) {
    return widget.controller.history == null
        ? Padding(
              padding: EdgeInsets.symmetric(vertical: 30,horizontal: 35),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Helper.sizedCircularProgressIndicator(width: 20,height: 20,strokeWidth: 1.5,color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
                    //SizedBox(height: 15,),
                    //Text(getTranslated(context,"please_wait"),style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w100,color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),),
                  ],
                ),
              )
          )
        : widget.controller.history.length == 0
          ? Padding(
                padding: EdgeInsets.symmetric(vertical: 30,horizontal: 35),
                child: Center(child: Text(getTranslated(context,"no_data"),style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w100,color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),)),
            )
          : ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 30),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.controller.history.length,
      itemBuilder: (context,index)
      {
        return HistoryItem(widget.controller.history[index]);
      },
      separatorBuilder: (context,index){
        return SizedBox(height: 10,);
      },
    );
  }
}
