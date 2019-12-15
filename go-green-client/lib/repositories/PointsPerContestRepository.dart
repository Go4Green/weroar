
import 'dart:convert';

import 'package:go_green/models/pointsPerDay.dart';
import 'package:go_green/pointsPerContest.dart';
import 'package:http/http.dart';

class PointsPerContestRepository {

  static Future<List<PointsPerDay>> getPointsPerContestForUser(int id) async {
    Response response = await get('http://10.0.2.2:8080/statistics/dailystats/all?userid=$id');
    List<dynamic> responseList = jsonDecode(response.body);
      
    List<PointsPerDay> poinstPerContestList = List();
    for (Map pointsPerContest in responseList) {
        PointsPerDay pointsPerDay = PointsPerDay.fromJson(pointsPerContest);
        poinstPerContestList.add(pointsPerDay);
      }
      
      return poinstPerContestList;
  }
}