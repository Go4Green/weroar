import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_green/mainScreen.dart';
import 'package:go_green/selectContestScreen.dart';
import 'package:go_green/statsScreen.dart';
import 'package:go_green/stepsScreen.dart';

import 'challengeScreen.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Colors.white,
      notchMargin: 8,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton( 
              iconSize: 20,
              icon: Icon(FontAwesomeIcons.shoePrints, color: Colors.green,),
              onPressed: () => Navigator.of(context).push(new PageRouteBuilder(
                          pageBuilder: (BuildContext context, _, __) {
                            return StepsScreen();
                          },
                        )),
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.chartBar, color: Colors.green),
              onPressed: () => Navigator.of(context).push(new PageRouteBuilder(
                          pageBuilder: (BuildContext context, _, __) {
                            return StatsScreen();
                          },
                        )),
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.trophy, color: Colors.green),
              onPressed: () => Navigator.of(context).push(new PageRouteBuilder(
                          pageBuilder: (BuildContext context, _, __) {
                            return ContestSelectScreen();
                          },
                        )),
            ),
            IconButton(
              icon: Icon(Icons.person_outline, color: Colors.green),
              onPressed: () => Navigator.of(context).push(new PageRouteBuilder(
                          pageBuilder: (BuildContext context, _, __) {
                            return MainScreen();
                          },
                        )),
            )
            
          ],
        ),
      ),
    );
  }
}