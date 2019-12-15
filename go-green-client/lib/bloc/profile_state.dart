import 'package:go_green/models/user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfileState {}
  
class InitialProfileState extends ProfileState {}

class FetchedProfile extends ProfileState {
  User user;

  FetchedProfile(User user) {
    this.user = user;
  }
}
