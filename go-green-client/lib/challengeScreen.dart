import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_green/challenge.dart';
import 'package:go_green/profile.dart';

import 'BottomBar.dart';
import 'bloc/challenge_bloc.dart';

class ChallengeScreen extends StatelessWidget {
  int challenge;

  ChallengeScreen(this.challenge);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ChallengeBloc(),
        child: Challenge(challenge)),
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