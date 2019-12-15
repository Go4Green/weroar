class Prize {
  int position;
  double prize;
  String description;
  String sponsor;

  Prize.fromJson(Map<String, dynamic> json)
    : position = json['position'],
      prize = json['prize'],
      description = json['prizeDescription'],
      sponsor = json['sponsor'];
}