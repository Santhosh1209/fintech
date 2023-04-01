import 'package:logger/logger.dart';
import '../model/user_data.dart';
import 'package:http/http.dart' as http;

class ApiConstants {
  static String baseUrl = 'https://jsonplaceholder.typicode.com';
  static String usersEndpoint = '/users';
}

var logger = Logger();

class ApiService {
  Future<List<User>?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<User> model = userFromJson(response.body);
        return model;
      }
    } catch (e) {
      logger.e(e.toString());
    }
    return null;
  }
}