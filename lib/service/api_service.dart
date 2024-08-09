import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khm_app/models/profile_model.dart';

class ApiService {
  static const String _baseUrl = 'https://wedangtech.my.id/api_personal';

  Future<ProfileModel> loginApi(email, password) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("$_baseUrl/login_api.php"));
    request.fields.addAll({'login': '', 'email': email, 'password': password});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      ProfileModel responseJson =
          ProfileModel.fromApiJson(jsonDecode(responseString));
      return responseJson;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future registerFirstApi(Map<String, String> data) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("$_baseUrl/login_api.php"));
    request.fields.addAll(data);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to register');
    }
  }

  Future getProductsApi(
      {String? keyword, String? filter, int? lim, int? page}) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "$_baseUrl/produk_api.php?allProduk&keyword=${keyword ?? ''}&fil=${filter ?? ''}&lim=${lim ?? ''}&page=${page ?? ''}"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to get product');
    }
  }
}
