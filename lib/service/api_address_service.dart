import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiAddressService {
  static const String _addressUrl = 'https://kodepos-2d475.firebaseio.com';

  Future getIndonesiaProvince() async {
    var request = http.MultipartRequest(
      'GET',
      Uri.parse("$_addressUrl/list_propinsi.json"),
    );

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to fetch province');
    }
  }

  Future getIndonesiaDistrict(String provinceId) async {
    var request = http.MultipartRequest(
      'GET',
      Uri.parse("$_addressUrl/list_kotakab/$provinceId.json"),
    );

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to fetch city');
    }
  }

  Future getIndonesiaSubdistrict(String cityId) async {
    var request = http.MultipartRequest(
      'GET',
      Uri.parse("$_addressUrl/kota_kab/$cityId.json"),
    );

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to fetch city');
    }
  }
}
