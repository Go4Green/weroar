import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_green/models/user.dart';

import 'bloc/bloc.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is InitialProfileState) {
              profileBloc.add(FetchProfile());
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is FetchedProfile) {
              return profileUi(context, state.user);
            }
        },
      );
  }

  Widget profileUi(BuildContext context, User user) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ClipPath(
          clipper: ProfileClipper(),
          child: Container(
            height: 250,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.green, Colors.lightGreen[400]])),
          ),
        ),
        Positioned(
          top: 115,
          left: 150,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(),
            child: CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('images/theo.jpeg'),
            ),
          ),
        ),
        SizedBox(
          height: 300,
        ),
        Positioned(
          top: 245,
          height: 500,
          // top: 180,
          child: Container(
            // height: MediaQuery.of(context).size.height * 2,
            width: MediaQuery.of(context).size.width / 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    statCard(context, '153000', 'steps',
                        FontAwesomeIcons.shoePrints, Colors.brown),
                    statCard(context, '${user.coins}', 'coins',
                        FontAwesomeIcons.moneyBillWave, Colors.green),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    statCard(context, '142h', 'of biking',
                        FontAwesomeIcons.bicycle, Colors.indigo),
                    statCard(context, '3', 'wins', FontAwesomeIcons.trophy,
                        Colors.amber),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget statCard(BuildContext context, String bigText, String smallText,
      IconData icon, Color iconColor) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      onTap: () => print(context),
      child: Container(
        width: 150,
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5)
            ]),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Text(
              bigText,
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              endIndent: 30,
              indent: 30,
              thickness: 2,
              color: Colors.green,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      smallText,
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: MediaQuery.of(context).size.width / 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Icon(
                  icon,
                  color: iconColor,
                )
              ],
            ),
          ],
        ),
      ),

      // child: Card(
      //   clipBehavior: Clip.antiAlias,
      //   elevation: 10,

      // ),
    );
  }
}

class ProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 250);
    path.lineTo(600, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return null;
  }
}
