import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_green/steps.dart';

import 'BottomBar.dart';
import 'bloc/steps_bloc.dart';

class StepsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => StepsBloc(),
        child: Steps()),
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