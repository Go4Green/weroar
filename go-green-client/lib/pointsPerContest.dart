import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_green/bloc/bloc.dart';
import 'package:go_green/bloc/pointspercontest_bloc.dart';
import 'package:go_green/models/pointsPerDay.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:go_green/statsScreen.dart';

class PointsPerContest extends StatelessWidget {
  List<Widget> pointsPerDayz(List<PointsPerDay> pointsPerDay) {
    List<Text> textList = List();
    print(pointsPerDay.length);
    for (PointsPerDay day in pointsPerDay) {
      textList.add(Text(day.dailyPoints.toString()));
    }
    return textList;
  }

  Widget pointsPerDayGraph(
      BuildContext context, List<PointsPerDay> pointsPerDay) {
    return Container(
      height: 800,
      width: 470,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 670,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.black26,
                  spreadRadius: 3,
                  offset: Offset(2, 5),
                )
              ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Total Points per Contest', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                Container(
                  height: 465,
                  width: 330,
                  child: charts.BarChart(
                    StackedFillColorBarChart.createSampleData(),
                    animate: false,
                    // Configure a stroke width to enable borders on the bars.
                    defaultRenderer: charts.BarRendererConfig(
                        groupingType: charts.BarGroupingType.stacked,
                        cornerStrategy: const charts.ConstCornerStrategy(30),
                        strokeWidthPx: 2.0),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PointspercontestBloc pointsPerContestBloc =
        BlocProvider.of<PointspercontestBloc>(context);
    return BlocBuilder<PointspercontestBloc, PointspercontestState>(
      builder: (context, state) {
        if (state is InitialPointspercontestState) {
          pointsPerContestBloc.add(FetchPointsPerDay());
          return CircularProgressIndicator();
        }
        if (state is PointsPerDayRetrieved) {
          return pointsPerDayGraph(context, state.pointsPerDayList);
        }
      },
    );
  }
}
