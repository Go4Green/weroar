import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_green/bloc/pointspercontest_bloc.dart';
import 'package:go_green/challenge.dart';
import 'package:go_green/pointsPerContest.dart';
import 'package:go_green/profile.dart';

import 'BottomBar.dart';
import 'bloc/challenge_bloc.dart';

class PointsPerContestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => PointspercontestBloc(),
        child: PointsPerContest()),
    );
  }
}