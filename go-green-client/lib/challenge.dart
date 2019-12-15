import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_green/bloc/bloc.dart';
import 'package:go_green/models/contest.dart';
import 'package:go_green/models/contestUser.dart';
import 'package:go_green/models/prize.dart';
import 'package:go_green/repositories/challengeRepository.dart';
import 'package:go_green/repositories/userRepository.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'bloc/challenge_bloc.dart';
import 'bloc/challenge_state.dart';

class Challenge extends StatelessWidget {
  int challengeNum;

  Challenge(this.challengeNum);

  registerToContest(BuildContext context, int challenge) async {
    String message = await UserRepository.registerToContest();
    if (message != null) {
      showFailDialog(context, message, challenge);
    } else {
      ChallengeBloc challengeBloc = BlocProvider.of<ChallengeBloc>(context);
      challengeBloc.add(SignUp(challengeNum));
    }
    Navigator.pop(context);
  }

  showFailDialog(BuildContext context, String message, int challenge) async {
    Contest contest = await ChallengeRepository.getContest(challenge);
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
        side: BorderSide(
          color: Colors.green,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.indigo,
      ),
    );

    Alert(
        context: context,
        style: alertStyle,
        type: AlertType.error,
        title: "Something went wrong",
        desc: message,
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: Colors.red[600],
            radius: BorderRadius.circular(10.0),
          ),
        ],
        closeFunction: () => print('swage')).show();
  }

  showSuccessDialog(BuildContext context, int challenge) async {
    Contest contest = await ChallengeRepository.getContest(challenge);
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
        side: BorderSide(
          color: Colors.green,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.indigo,
      ),
    );

    Alert(
        context: context,
        style: alertStyle,
        type: AlertType.info,
        title: "Confirm Registration",
        desc:
            contest.id == 1 ? "${contest.participationCost} coins \n\nAre you sure you want to enter January's contest?" : "Are you sure you want to enter January's contest?",
        buttons: [
          DialogButton(
            child: Text(
              "Yes",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => registerToContest(context, challenge),
            color: Colors.green[600],
            radius: BorderRadius.circular(10.0),
          ),
          DialogButton(
            child: Text(
              "No",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: Colors.red[600],
            radius: BorderRadius.circular(10.0),
          ),
        ],
        closeFunction: () => print('swage')).show();
  }

  showPrizes(BuildContext context, int challenge) async {
    Contest contest = await ChallengeRepository.getContest(challenge);
    List<Prize> prizes = await ChallengeRepository.getPrizes(challenge);
    contest.prizes = prizes;
    Map<int, dynamic> prizesMap = new Map();
    for (Prize prize in prizes) {
      if (prize.prize == 0) {
        prizesMap[prize.position] = prize.description;
      } else {
        prizesMap[prize.position] = prize.prize;
      }
    }
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      
      isCloseButton: false,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber[600]),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
        side: BorderSide(
          color: Colors.green,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.blueGrey,
      ),
    );

    Alert(
        context: context,
        style: alertStyle,
        type: AlertType.none,
        title: "Prizes",
        content: DottedBorder(
          color: Colors.green,
          borderType: BorderType.RRect,
          dashPattern: [1000, 1000],
          radius: Radius.circular(10),
          strokeWidth: 4,
          padding: EdgeInsets.all(8),
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  Text('1', style: TextStyle(color: Colors.amber[800]),),
                  Text(prizesMap[1].toString(), style: TextStyle(color: Colors.green))
                ]
              ),
              TableRow(
                children: [
                  Divider(color: Colors.green, thickness: 2,),
                  Divider(color: Colors.green, thickness: 2,),
                ]
              ),
              TableRow(
                children: [
                  Text('2', style: TextStyle(color: Colors.grey)),
                  Text(prizesMap[2].toString(), style: TextStyle(color: Colors.green))
                ]
              ),
              TableRow(
                children: [
                  Divider(color: Colors.green, thickness: 2,),
                  Divider(color: Colors.green, thickness: 2,),
                ]
              ),
              TableRow(
                children: [
                  Text('3', style: TextStyle(color: Colors.deepOrange)),
                  Text(prizesMap[3].toString(), style: TextStyle(color: Colors.green))
                ]
              ),
              TableRow(
                children: [
                  Divider(color: Colors.green, thickness: 2,),
                  Divider(color: Colors.green, thickness: 2,),
                ]
              ),
              TableRow(
                children: [
                  Text('4 - 50', style: TextStyle(color: Colors.green)),
                  Text(prizesMap[4].toString(), style: TextStyle(color: Colors.green))
                ]
              ),
            ],
          ),
        ),
        
        closeFunction: () => print('swage')).show();
  }

  Widget challengeLandingPage(BuildContext context, int challenge) {
    return Column(
      children: <Widget>[
        Container(
          height: 645,
          width: 400,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.green, Colors.lightGreen[400]]),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(500),
                  bottomRight: Radius.circular(5000))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 10,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Container(
                  height: 505,
                  width: 300,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'January\'s green challenge!',
                          style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  'Be',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  'Green',
                                  style: TextStyle(
                                      color: Colors.green[600],
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  'to Win!',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(3.0),
                              //   child: Text('Win!', style: TextStyle(color: Colors.green[600], fontSize: 21, fontWeight: FontWeight.bold),),
                              // ),
                            ],
                          )),
                      Container(
                        height: 250,
                        width: 250,
                        // color: Colors.green,
                        child: Card(
                          // color: Colors.green,
                          color: Color.fromRGBO(139, 0, 84, 1),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                'Bring your',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                              Icon(
                                FontAwesomeIcons.bicycle,
                                color: Colors.white,
                                size: 70,
                              ),
                              Text(
                                'And go gettem!',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: MaterialButton(
                          child: Text(
                            'I\'m up for the challenge!',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            ChallengeBloc challengeBloc =
                                BlocProvider.of<ChallengeBloc>(context);
                            showSuccessDialog(context, challengeNum);
                          },
                          elevation: 10,
                          // color: Colors.green,
                          color: Color.fromRGBO(139, 0, 84, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                        ),
                      ),
                      Container(
                        child: MaterialButton(
                          child: Text(
                            'See the participants first',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            ChallengeBloc challengeBloc =
                                BlocProvider.of<ChallengeBloc>(context);
                            challengeBloc.add(ViewParticipants(challengeNum));
                          },
                          elevation: 10,
                          color: Colors.indigo,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          // height: 200,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Text(
                'Registrations end on',
                style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              Text(
                '10 of January 2020',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
            ],
          ),
          // child: Text('Registrations end in: 12h and 27m'),
        )
      ],
    );
  }

  Widget contestUserCard(BuildContext context, ContestUser user,
      Color borderColor, Color cardColor, bool isMyUser) {
    return Container(
      height: MediaQuery.of(context).size.height / 7,
      width: MediaQuery.of(context).size.height / 7,
      color: Colors.transparent,
      margin: EdgeInsets.only(left: 8, right: 8),
      child: Card(
        color: isMyUser ? Colors.greenAccent : cardColor,
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 8),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.height / 8,
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: borderColor, width: 4),
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                width: MediaQuery.of(context).size.height / 10,
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/theo.jpeg"),
                  radius: 100,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  user.user.username,
                  style: TextStyle(
                      color: Colors.green[700],
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                    width: 130,
                    child: Text(
                      '${user.user.surename}, ${user.user.name}',
                      style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            Container(
              margin: EdgeInsets.all(18),
              child: Row(
                children: <Widget>[
                  Text(user.totalContestPoints.toString(),
                      style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      )),
                  Icon(
                    FontAwesomeIcons.leaf,
                    size: 35,
                    color: Colors.green[700],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> contestUserCards(BuildContext context, List<ContestUser> users) {
    List<Container> userCards = List();
    Container title = Container(
        margin: EdgeInsets.all(8),
        child: Text(
          'Registered Participants:',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ));
    userCards.add(title);
    for (int i in Iterable<int>.generate(users.length)) {
      print('yolo');
      Color borderColor = i == 0
          ? Colors.amber
          : i == 1
              ? Colors.grey[600]
              : i == 2 ? Colors.deepOrange[500] : Colors.indigo;
      Color cardColor = i % 2 == 0 ? Colors.white : Colors.grey[300];
      bool isMyUser = users[i].user.username == 'trixakias';
      Container userCard =
          contestUserCard(context, users[i], borderColor, cardColor, isMyUser);
      userCards.add(userCard);
    }
    print(userCards.length);
    return userCards;
  }

  Widget participantsView(BuildContext context, List<ContestUser> users) {
    return Container(
      height: 800,
      width: 420,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green, Colors.lightGreen[400]]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Container(
            color: Colors.transparent,
            height: 610,
            width: 380,
            child: Card(
              color: Color.fromRGBO(139, 0, 84, 0.1),
              elevation: 20,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: ListView(children: contestUserCards(context, users)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 350,
            height: 40,
            child: MaterialButton(
              onPressed: () => showPrizes(context, challengeNum),
              color: Colors.amber[600],
              child: Text(
                'See the prizes',
                style: TextStyle(color: Colors.white),
              ),
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(30, 70))),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final challengeBloc = BlocProvider.of<ChallengeBloc>(context);
    return BlocBuilder<ChallengeBloc, ChallengeState>(
      builder: (context, state) {
        if (state is InitialChallengeState) {
          return challengeLandingPage(context, challengeNum);
        }
        if (state is ViewingParticipants) {
          for (ContestUser user in state.contestUsers) {
            print(user.user.username);
          }
          return participantsView(context, state.contestUsers);
        }
      },
    );
  }
}
