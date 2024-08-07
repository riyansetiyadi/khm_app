import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://wedangtech.my.id/api_personal';

  Future loginApi(email, password) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("$_baseUrl/login_api.php"));
    request.fields.addAll({'login': '', 'email': email, 'password': password});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to login');
    }
  }
}
