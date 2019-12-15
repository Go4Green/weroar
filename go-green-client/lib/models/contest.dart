import 'package:go_green/models/prize.dart';

class Contest {
  int id;
  int participationCost;
  DateTime startingDate;
  DateTime endingDate;
  List<Prize> prizes;

  Contest.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        participationCost = json['participationCost'],
        startingDate = DateTime.parse(json['startingDate']),
        endingDate = DateTime.parse(json['endingDate']) 
        ;
  
}