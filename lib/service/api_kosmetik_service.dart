import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'package:khm_app/models/profile_model.dart';

class ApiKosmetikService {
  static const String _baseUrl = 'https://wedangtech.my.id/api_personal';
  static const String _chatUrl = 'https://wedangtech.my.id';

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
      'checkout': '',
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
    // print(await response.stream.bytesToString());
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
    File? img,
  }) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("$_chatUrl/chat_api.php"));
    request.fields.addAll({
      'room': room,
      'dari': 'pasien',
      'dari_id': token,
      'token': token,
      'type': (img == null) ? 'text' : 'file',
      'message': (img == null) ? message : p.basename(img.path),
    });

    if (img != null)
      request.files.add(await http.MultipartFile.fromPath('foto', img.path));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to send messages');
    }
  }

  Future getMessageApi(String idRoom, String token) async {
    var request = http.MultipartRequest('GET',
        Uri.parse("$_baseUrl/../chat_api.php?getPesan=$idRoom&token=$token"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to GET the Message');
    }
  }

  Future getTransactionsApi(String token) async {
    var request = http.MultipartRequest('GET',
        Uri.parse("$_baseUrl/history_api.php?allHistoryUser&token=$token"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to GET the Historys');
    }
  }

  Future getTransactionByNota(String token, String nota) async {
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            "$_baseUrl/history_api.php?allHistoruUserProduk&token=$token&code_nota=$nota"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      return responseJson;
    } else {
      throw Exception('Failed to GET the Historys');
    }
  }

  Future uploadBuktiPembayaranApi(
      String token, String nota, File? buktiPembayaran) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("$_baseUrl/history_api.php"));
    request.fields.addAll(
        {'token': token, 'uploadBuktiPembayaran': '', 'code_nota': nota});
    request.files.add(await http.MultipartFile.fromPath(
        'foto_bukti', buktiPembayaran?.path ?? ''));
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
}
