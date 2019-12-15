import 'dart:convert';

import 'package:go_green/models/user.dart';
import 'package:http/http.dart';

class UserRepository {
  static Future<User> getUser() async {
    Response userResponse = await get('http://10.0.2.2:8080/user/1');
    User user = User.fromJson(jsonDecode(userResponse.body));
    print('${user.username}');
    return user;
  }

  static Future<String> registerToContest() async {
      Response response = await post('http://10.0.2.2:8080/user/1/registerContest?contestId=1');
      print("response: ${response.body}");
      if (response.statusCode != 200) {
        return jsonDecode(response.body)['message'];
      }
    }
}
