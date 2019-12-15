import 'package:go_green/models/pointsPerDay.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PointspercontestState {}
  
class InitialPointspercontestState extends PointspercontestState {}

class PointsPerDayRetrieved extends PointspercontestState {
  List<PointsPerDay> pointsPerDayList;

  PointsPerDayRetrieved(this.pointsPerDayList);
}
