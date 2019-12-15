import 'dart:convert';

import 'package:go_green/models/contest.dart';
import 'package:go_green/models/contestUser.dart';
import 'package:go_green/models/prize.dart';
import 'package:http/http.dart';

class ChallengeRepository {

    static Future<Contest> getContest(int challenge) async {
      Response response = await get('http://10.0.2.2:8080/contest/$challenge');
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      
      Contest contest = Contest.fromJson(responseMap);
      
      return contest;
    }
    
    static Future<List<ContestUser>> getContestParticipants(int contestId) async {
      Response response = await get('http://10.0.2.2:8080/contest/users?contestid=$contestId');
      List<dynamic> responseMap = jsonDecode(response.body);
      List<ContestUser> contestUsers = List();
      for (Map contestUserMap in responseMap) {
        ContestUser contestUser = ContestUser.fromJson(contestUserMap);
        contestUsers.add(contestUser);
      }
      
      return contestUsers;
    }

  static Future<List<Prize>> getPrizes(int challenge) async {
    Response response = await get('http://10.0.2.2:8080/contest/prizes?contestid=$challenge');
    List<dynamic> responseMap = jsonDecode(response.body);
    List<Prize> prizes = List();
    for (Map prizeMap in responseMap) {
      Prize prize = Prize.fromJson(prizeMap);
      prizes.add(prize);
    }
      
    return prizes;
  }
}