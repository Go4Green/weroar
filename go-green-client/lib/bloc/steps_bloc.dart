import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class StepsBloc extends Bloc<StepsEvent, StepsState> {
  @override
  StepsState get initialState => InitialStepsState();

  @override
  Stream<StepsState> mapEventToState(
    StepsEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
