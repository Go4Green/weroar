import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_green/profile.dart';

import 'BottomBar.dart';
import 'bloc/bloc.dart';
import 'models/user.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: BlocProvider(
        create: (context) => ProfileBloc(),
        child: Profile(),
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