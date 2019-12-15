import 'package:flutter/material.dart';
import 'package:go_green/challengeScreen.dart';

class ContestSelect extends StatelessWidget {

  Widget freeContest(BuildContext context) {
    return GestureDetector(
          onTap: () => Navigator.of(context).push(new PageRouteBuilder(
                          pageBuilder: (BuildContext context, _, __) {
                            return ChallengeScreen(2);
                          },
                        )),
          child: Container(
            color: Colors.transparent,
            height: 200,
            width: 250,
        child: Card(
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: Text('Join Paid Contest', style: TextStyle(color: Colors.amber, fontSize: 25),)
          ),
        ),
      ),
    );
  }

   Widget paidContest(BuildContext context) {
    return GestureDetector(
          onTap: () => Navigator.of(context).push(new PageRouteBuilder(
                          pageBuilder: (BuildContext context, _, __) {
                            return ChallengeScreen(1);
                          },
                        )),
          child: Container(
            color: Colors.transparent,
            height: 200,
            width: 250,
        child: Card(
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: Text('Join Free Contest', style: TextStyle(color: Colors.indigo, fontSize: 25),)
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green, Colors.lightGreen[400]]),
      ),
      height: 780,
      width: 450,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // Text('What kind of contest do you want?', style: TextStyle(color: Colors.white, fontSize: 25)),
          freeContest(context),
          paidContest(context)
        ],
      ),
    );
  }
}
