import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khm_app/models/profile_model.dart';

class ApiService {
  static const String _baseUrl = 'https://wedangtech.my.id/api_personal';
  static const String _addressUrl = 'https://kodepos-2d475.firebaseio.com';

  Future<ProfileModel> loginApi(email, password) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("$_baseUrl/login_api.php"));
    request.fields.addAll({
      'login': '',
      'email': email,
      'password': password,
    });

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
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$_baseUrl/login_api.php"),
    );
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

  Future registerConsultationApi(
    String gender,
    String idNumber,
    String token,
  ) async {
    print(idNumber);
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$_baseUrl/login_api.php"),
    );
    request.fields.addAll({
      'registerKe2': '',
      'jenis_kelamin': gender,
      'no_identitas': idNumber,
      'token': token,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to register');
    }
  }

  Future registerShopApi(
    String province,
    String district,
    String subdistrict,
    String village,
    String postalCode,
    String address,
    String token,
  ) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$_baseUrl/login_api.php"),
    );
    request.fields.addAll({
      'registerKe3': '',
      'provinsi': province,
      'kota': district,
      'kecamatan': subdistrict,
      'kelurahan': village,
      'kode_pos': postalCode,
      'alamat': address,
      'token': token,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to register');
    }
  }

  Future getProductsApi({
    String? keyword,
    String? filter,
    int? lim,
    int? page,
  }) async {
    var request = http.MultipartRequest(
      'GET',
      Uri.parse(
          "$_baseUrl/produk_api.php?allProduk&keyword=${keyword ?? ''}&fil=${filter ?? ''}&lim=${lim ?? ''}&page=${page ?? ''}"),
    );

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to get products');
    }
  }

  Future getBestSellerProductsApi({
    bool? isBestSeller,
  }) async {
    var request = http.MultipartRequest(
      'GET',
      Uri.parse(
          "$_baseUrl/produk_api.php?produkTerlaris=${isBestSeller?.toString() ?? ''}"),
    );

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      print(responseJson);
      return responseJson;
    } else {
      throw Exception('Failed to get products');
    }
  }

  Future getProductApi(int id) async {
    var request = http.MultipartRequest(
      'GET',
      Uri.parse("$_baseUrl/produk_api.php?singleProduk&produk=$id"),
    );

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to get product');
    }
  }

  Future getCartsApi(String token) async {
    var request = http.MultipartRequest('GET',
        Uri.parse("$_baseUrl/keranjang_api.php?getKeranjangUser&token=$token"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to get Cart');
    }
  }

  Future updateQuantityProductCartApi(
      String quantity, String idCart, String token) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("$_baseUrl/keranjang_api.php"));
    request.fields.addAll({
      'updateJumlah': '',
      'jumlah': quantity,
      'id': idCart,
      'token': token,
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to update quantity cart product');
    }
  }

  Future delKeranjang(int idCart, String token) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("$_baseUrl/keranjang_api.php"));
    request.fields.addAll({
      'delKeranjang': '',
      'idCart': idCart.toString(),
      'token': token,
    });
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to delete cart product');
    }
  }

  Future checkoutApi(
    String token,
    String fullname,
    String completeAddress,
    String phoneNumber,
  ) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("$_baseUrl/keranjang_api.php"));
    request.fields.addAll({
      'token': token,
      'nama_lengkap': fullname,
      'alamat_lengkap': completeAddress,
      'no_telp': phoneNumber,
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to CHECK OUT the cart');
    }
  }

  Future createRoomChatApi(String uniqeCode) async {
    var request = http.MultipartRequest('GET',
        Uri.parse("$_baseUrl/chat_room_api.php?addRoom&token=$uniqeCode"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to create room chat');
    }
  }

  Future sendMessageApi(
    String token,
    String room,
    String fullname,
    String message, {
    String? filepath,
  }) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("$_baseUrl/chat_api.php"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to create room chat');
    }
  }

  Future getPesan(int idRoom) async {
    var request = http.MultipartRequest(
        'GET', Uri.parse("$_baseUrl/../chat_api.php?getPesan=$idRoom"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to GET the Message');
    }
  }

  Future allHistoryUser(String uniqeCode) async {
    var request = http.MultipartRequest('GET',
        Uri.parse("$_baseUrl/history_api.php?allHistoryUser&token=$uniqeCode"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to GET the Historys');
    }
  }

  Future allHistoruUserProduk(String uniqeCode, int code_nota) async {
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            "$_baseUrl/history_api.php?allHistoruUserProduk&token=$uniqeCode&code_nota=$code_nota"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to GET the Historys');
    }
  }

  Future uploadBuktiPembayaran(Map<String, String> data) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("$_baseUrl/history_api.php"));
    request.fields.addAll(data);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to upload pembayaran');
    }
  }

  Future addProductToCart(int id, String token) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$_baseUrl/keranjang_api.php"),
    );
    request.fields.addAll({
      'addKeranjang': '',
      'idProduk': id.toString(),
      'token': token,
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to add product to cart');
    }
  }

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
