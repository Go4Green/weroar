/// Bar chart example
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_green/linearGraph.dart';
import 'package:go_green/models/pointsPerDay.dart';
import 'package:go_green/pointePerContestScreen.dart';

import 'BottomBar.dart';
import 'bloc/bloc.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => ChallengeBloc(), 
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ClipPath(
          clipper: StatsClipper(),
          child: Container(
            height: 650,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [ Colors.lightGreen[400], Colors.green,])),
          ),
        ),
            Positioned(
              height: 250,
              width: 250,
              top: 220,
              right: 175,
              
                child: InkWell(
                  onTap: () => Navigator.of(context).push(new PageRouteBuilder(
                          pageBuilder: (BuildContext context, _, __) {
                            return PointsPerContestScreen();
                                                      },
                                                    )),
                                              child: Column(
                                                children: <Widget>[
                                                  Icon(FontAwesomeIcons.chartBar, color: Colors.white, size: 45,),
                                                  Text('Total points', style: TextStyle(color: Colors.white, fontSize: 25),),
                                                ],
                                              ),
                                          ),
                                        ),
                                        Positioned(
                                          height: 250,
                                          width: 250,
                                          top: 520,
                                          right: 0,
                                          
                                            child: InkWell(
                                              onTap: () => Navigator.of(context).push(new PageRouteBuilder(
                          pageBuilder: (BuildContext context, _, __) {
                            return LinearGraph();
                                                      },
                                                    )),
                                              child: Column(
                                                children: <Widget>[
                                                  Icon(FontAwesomeIcons.chartLine, color: Colors.green, size: 45,),
                                                  Text('Green event points', style: TextStyle(color: Colors.green, fontSize: 25),),
                                                ],
                                              ),
                                          ),
                                        )
                                        ],
                                      )
                                      ),
                                  bottomNavigationBar: BottomBar(),
                                  floatingActionButton: FloatingActionButton(
                                    onPressed: () => print('swag'),
                                    backgroundColor: Colors.green,
                                    child: Icon(FontAwesomeIcons.leaf),
                                  ),
                                  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                                );
                              }
                            }
                            
                            class PointsPerDayScreen {
}

class StatsClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 750);
    path.lineTo(420, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return null;
  }
}

/// Example of a stacked bar chart with three series, each rendered with
/// different fill colors.
class StackedFillColorBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedFillColorBarChart(this.seriesList, {this.animate});

  factory StackedFillColorBarChart.withSampleData() {
    return new StackedFillColorBarChart(
      createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengeBloc, ChallengeState>(
        builder: (context, state) {
      return new charts.BarChart(
        seriesList,
        animate: animate,
        vertical: false,
        // Configure a stroke width to enable borders on the bars.
        defaultRenderer: new charts.BarRendererConfig(
          // By default, bar renderer will draw rounded bars with a constant
          // radius of 100.
          // To not have any rounded corners, use [NoCornerStrategy]
          // To change the radius of the bars, use [ConstCornerStrategy]
          cornerStrategy: const charts.ConstCornerStrategy(30)),
    
      );
    });
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('January', 5),
      new OrdinalSales('February', 25),
      new OrdinalSales('March', 100),
      new OrdinalSales('April', 75),
    ];

    final tableSalesData = [
      new OrdinalSales('January', 25),
      new OrdinalSales('February', 50),
      new OrdinalSales('March', 10),
      new OrdinalSales('April', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('January', 10),
      new OrdinalSales('February', 50),
      new OrdinalSales('March', 50),
      new OrdinalSales('April', 45),
    ];

    return [
      // Blue bars with a lighter center color.
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        fillColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
      ),
      // Solid red bars. Fill color will default to the series color if no
      // fillColorFn is configured.
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
      ),
      // Hollow green bars.
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        fillColorFn: (_, __) => charts.MaterialPalette.white,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
