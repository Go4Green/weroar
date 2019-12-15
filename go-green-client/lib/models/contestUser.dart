import 'package:go_green/models/contest.dart';
import 'package:go_green/models/user.dart';

class ContestUser {
  User user;
  Contest contest;
  int totalContestPoints;
  int greenDistancePoints;
  int eventPoints;

  ContestUser.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json['user']),
        contest = Contest.fromJson(json['contest']),
        totalContestPoints = json['totalPoints'],
        greenDistancePoints = json['greenDistancePoints'],
        eventPoints = json['eventPoints']
        ;
}