import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class EstadisticaPage extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  EstadisticaPage(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory EstadisticaPage.withSampleData() {
    return new EstadisticaPage(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('Paroniquia', 15),
      new OrdinalSales('Cancer', 48),
      new OrdinalSales('Dolor de Cabeza', 96),
      new OrdinalSales('Dolor de Barriga', 85),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
        // Set a label accessor to control the text of the bar label.
        labelAccessorFn: (OrdinalSales sales, _) =>
            '${sales.year}: ${sales.sales.toString()}\%',
        insideLabelStyleAccessorFn: (OrdinalSales sales, _) {
          final color = (sales.year == 'Paroniquia')
              ? charts.MaterialPalette.red.shadeDefault
              : charts.MaterialPalette.yellow.shadeDefault.darker;
          return new charts.TextStyleSpec(color: color);
        },
        outsideLabelStyleAccessorFn: (OrdinalSales sales, _) {
          final color = (sales.year == 'Cancer')
              ? charts.MaterialPalette.green.shadeDefault
              : charts.MaterialPalette.green.shadeDefault.darker;
          return new charts.TextStyleSpec(color: color);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Estadisticas',
              style: TextStyle(color: Colors.white, fontSize: 25.0)),
          backgroundColor: Color.fromRGBO(36, 247, 188, 1.0),
        ), //SingleChildScrollView
        body: Container(
          margin: EdgeInsets.all(60),
          child: charts.BarChart(
            seriesList,
            animate: animate,
            vertical: false,
            barRendererDecorator: new charts.BarLabelDecorator<String>(),
            // Hide domain axis.
            domainAxis: new charts.OrdinalAxisSpec(
                renderSpec: new charts.NoneRenderSpec()),
          ),
        ));
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
