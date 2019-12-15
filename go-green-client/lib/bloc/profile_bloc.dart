import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_health/flutter_health.dart';
import 'package:go_green/models/user.dart';
import 'package:go_green/repositories/userRepository.dart';
import './bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {



  @override
  ProfileState get initialState => InitialProfileState();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is FetchProfile) {
      User user = await UserRepository.getUser();
      await FlutterHealth.requestAuthorization();
      List<GFHealthData> data = await FlutterHealth.getGFHeight(DateTime.utc(2016), DateTime.now());
      // GFHealthData datum = data[0];
      print(user);
      yield FetchedProfile(user);
    }
  }
}
