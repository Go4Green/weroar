class PointsPerDay {
  int dailyPoints;
  int userId;
  String date;

  PointsPerDay.fromJson(Map<String, dynamic> json)
      : dailyPoints = json['dailyPoints'],
      userId = json['id']['userId'],
      date = json['id']['date'];
}