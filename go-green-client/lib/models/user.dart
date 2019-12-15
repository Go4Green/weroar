
class User {
  int coins;
  int wins;
  int totalSteps;
  int bikingHours = 142;
  String username;
  String name;
  String surename;

  User.fromJson(Map<String, dynamic> json)
      : coins = json['wallet'] != null ? json['wallet']['balance'] : 0,
        wins = 3,
        totalSteps = 153000,
        name = json['name'],
        surename = json['surname'],
        username = json['username']
        ;

  User(int coins, int wins, int totalSteps) {
    this.coins = coins;
    this.wins = wins;
    this.totalSteps = totalSteps;
  }
}