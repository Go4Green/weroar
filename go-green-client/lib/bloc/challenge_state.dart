import 'package:go_green/models/contestUser.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChallengeState {}
  
class InitialChallengeState extends ChallengeState {}

class ViewingParticipants extends ChallengeState {
  List<ContestUser> contestUsers;

  ViewingParticipants(this.contestUsers);
}
