import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:go_green/models/contestUser.dart';
import 'package:go_green/models/prize.dart';
import 'package:go_green/repositories/challengeRepository.dart';
import './bloc.dart';

class ChallengeBloc extends Bloc<ChallengeEvent, ChallengeState> {
  @override
  ChallengeState get initialState => InitialChallengeState();

  @override
  Stream<ChallengeState> mapEventToState(
    ChallengeEvent event,
  ) async* {
    if (event is ViewParticipants) {

      List<ContestUser> contestUsers = await ChallengeRepository.getContestParticipants(event.challenge);
      List<Prize> prizes = await ChallengeRepository.getPrizes(event.challenge);
      for (ContestUser user in contestUsers) {
        user.contest.prizes = prizes;
      }
      yield ViewingParticipants(contestUsers);
    } else if (event is SignUp) {

      List<ContestUser> contestUsers = await ChallengeRepository.getContestParticipants(event.challenge);
      List<Prize> prizes = await ChallengeRepository.getPrizes(event.challenge);
      yield ViewingParticipants(contestUsers);
    }
  }
  
}
