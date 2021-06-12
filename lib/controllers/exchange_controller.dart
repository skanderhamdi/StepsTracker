import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:steps_tracker/models/exchange_model.dart';

/* Exchange Page Controller */

class ExchangeController extends ControllerMVC
{
    GlobalKey<ScaffoldState> scaffoldKey;
    List<Exchange> exchanges;

    ExchangeController() {
        this.scaffoldKey = GlobalKey<ScaffoldState>();
        init();
    }

    /* get exchanges list from Model */
    Future<void> init() async
    {
      setState((){
        exchanges = [];
        exchanges = null;
      });
      exchanges = await Exchange.listenForExchanges();
      setState((){});
    }
}