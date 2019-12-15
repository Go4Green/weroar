import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_green/bloc/bloc.dart';
import 'package:go_green/statsScreen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Steps extends StatelessWidget {
  Widget stepsView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.lightGreen[400],
              Colors.green,
            ]),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 550,
            width: 550,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.lightGreen[400],
                    Colors.green,
                  ]),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Today',
                  style: TextStyle(color: Colors.white70, fontSize: 28),
                ),
                CircularPercentIndicator(
                  radius: 250.0,
                  lineWidth: 7.0,
                  percent: 0.67,
                  center: new Text(
                    "67%\ of\n\nRecommended\ngreen activity",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                  progressColor: Colors.blueGrey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Cycling',
                          style: TextStyle(color: Colors.white70, fontSize: 17),
                        ),
                        Text(
                          '2',
                          style: TextStyle(color: Colors.white70, fontSize: 28),
                        ),
                        Text(
                          'hours',
                          style: TextStyle(color: Colors.white70, fontSize: 17),
                        ),
                      ],
                    ),
                    VerticalDivider(
                      color: Colors.black,
                      width: 30,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Walking',
                          style: TextStyle(color: Colors.white70, fontSize: 17),
                        ),
                        Text(
                          '1.3',
                          style: TextStyle(color: Colors.white70, fontSize: 28),
                        ),
                        Text(
                          'hours',
                          style: TextStyle(color: Colors.white70, fontSize: 17),
                        ),
                      ],
                    ),
                    VerticalDivider(
                      color: Colors.white,
                      width: 30,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Activities',
                          style: TextStyle(color: Colors.white70, fontSize: 17),
                        ),
                        Text(
                          '1',
                          style: TextStyle(color: Colors.white70, fontSize: 28),
                        ),
                        Text(
                          'activity',
                          style: TextStyle(color: Colors.white70, fontSize: 17),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 197.4,
            width: 440,
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              children: <Widget>[
                Container(
                  height: 25,
                    // margin: EdgeInsets.only(top: 1),
                    child: IconButton(
                      icon: Icon(FontAwesomeIcons.chevronCircleUp,
                          size: 25, color: Colors.blueGrey),
                      onPressed: () =>
                          Navigator.of(context).push(new PageRouteBuilder(
                        pageBuilder: (BuildContext context, _, __) {
                          return StatsScreen();
                        },
                      )),
                    )),
                Container(
                  height: 155,
                  width: 370,
                  child: charts.BarChart(
                    StackedFillColorBarChart.createSampleData(),
                    animate: false,
                    // Configure a stroke width to enable borders on the bars.
                    defaultRenderer: charts.BarRendererConfig(
                        groupingType: charts.BarGroupingType.stacked,
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
    final stepsBloc = BlocProvider.of<StepsBloc>(context);
    return BlocBuilder<StepsBloc, StepsState>(
      builder: (context, state) {
        if (state is InitialStepsState) {
          return stepsView(context);
        }
        // if (state is ViewingParticipants) {
        //   for (ContestUser user in state.contestUsers) {
        //     print(user.user.username);
        //   }
        //   return participantsView(context, state.contestUsers);
        // }
      },
    );
  }
}
