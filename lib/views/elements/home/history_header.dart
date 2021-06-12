import 'package:flutter/material.dart';
import 'package:steps_tracker/controllers/home_controller.dart';
import 'package:steps_tracker/localization/language_constants.dart';

// ignore: must_be_immutable
class HistoryHeader extends StatefulWidget {
  HomeController controller;
  HistoryHeader(this.controller);
  @override
  _HistoryHeaderState createState() => _HistoryHeaderState();
}

class _HistoryHeaderState extends State<HistoryHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(getTranslated(context,"history"),style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w800,color: Theme.of(context).colorScheme.primary),),
          /*InkWell(
            onTap:()
            {
                widget.controller.switchShowChart();
            },
            child: Container(
              padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: widget.controller.showChart ? Theme.of(context).colorScheme.secondary : Colors.black.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(2)
                ),
                child: Icon(Icons.bar_chart,color: widget.controller.showChart ? Colors.white : Colors.black.withOpacity(0.25),)
            ),
          )*/
        ],
      ),
    );
  }
}
