import 'package:meta/meta.dart';

@immutable
abstract class ChallengeEvent {}

class SignUp extends ChallengeEvent {
  int challenge;

  SignUp(this.challenge);
}

class ViewParticipants extends ChallengeEvent {
  int challenge;

  ViewParticipants(this.challenge);
}