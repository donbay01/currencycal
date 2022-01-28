// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ChartWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child:  charts.TimeSeriesChart(
        _createSampleData(),
        animate: true,
        dateTimeFactory: charts.LocalDateTimeFactory(),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeRates, DateTime>> _createSampleData() {
    final data = [
      TimeRates(DateTime(2021, 10, 19),500),
      TimeRates(DateTime(2021, 12, 26), 55),
      TimeRates(DateTime(2022, 1, 3), 200),
      TimeRates(DateTime(2022, 2, 10), 200),

    ];

    return [
      charts.Series<TimeRates, DateTime>(
        id: 'Rates',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeRates rate, _) => rate.time,
        measureFn: (TimeRates rate, _) => rate.rate,
        data: data,
      )
    ];
  }
}

//time series data type.
class TimeRates {
  final DateTime time;
  final int rate;

  TimeRates(this.time, this.rate);
}