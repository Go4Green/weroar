import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:go_green/models/pointsPerDay.dart';
import 'package:go_green/repositories/PointsPerContestRepository.dart';
import './bloc.dart';

class PointspercontestBloc extends Bloc<PointspercontestEvent, PointspercontestState> {
  @override
  PointspercontestState get initialState => InitialPointspercontestState();

  @override
  Stream<PointspercontestState> mapEventToState(
    PointspercontestEvent event,
  ) async* {
    if (event is FetchPointsPerDay) {
      List<PointsPerDay> pointsPerDay = await PointsPerContestRepository.getPointsPerContestForUser(1);
      yield PointsPerDayRetrieved(pointsPerDay);
    }
  }
}
