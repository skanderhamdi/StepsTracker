/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:steps_tracker/controllers/home_controller.dart';
import 'package:steps_tracker/models/date_steps_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryChart extends StatefulWidget {
  HomeController controller;
  HistoryChart(this.controller);
  @override
  _HistoryChartState createState() => _HistoryChartState();
}

class _HistoryChartState extends State<HistoryChart> {
  @override
  Widget build(BuildContext context) {

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: SfCartesianChart(
          // Initialize category axis
              primaryXAxis: CategoryAxis(),
              series: <LineSeries<DateSteps, String>>[
              LineSeries<DateSteps, String>(
                // Bind data source
                  dataSource:  widget.controller.history,
                  xValueMapper: (DateSteps date, _) =>  DateFormat('EEEE').format(DateFormat("dd/MM/yyyy").parse(date.date)).substring(0,3)+", "+DateFormat('dd/MM').format(DateFormat("dd/MM/yyyy").parse(date.date)),
                  yValueMapper: (DateSteps date, _) => date.stepsCount
              )
            ]
        )
    );
  }
}
*/