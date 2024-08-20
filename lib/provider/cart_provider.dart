import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khm_app/db/auth_repository.dart';
import 'package:khm_app/models/cart_model.dart';
import 'package:khm_app/service/api_service.dart';
import 'package:khm_app/utils/enum_state.dart';

class CartProvider extends ChangeNotifier {
  final ApiService apiService;
  final AuthRepository authRepository;

  CartProvider(this.apiService, this.authRepository) {
    _init();
  }

  ResultState _resultState = ResultState.initial;
  ResultState get state => _resultState;

  String? message;
  List<CartModel>? products;
  bool changeQuantity = false;

  _init() async {}

  void incrementQuantity(String id) {
    for (CartModel product in products ?? []) {
      if (product.id == id &&
          product.jumlah < (int.tryParse(product.stok) ?? 0)) {
        product.jumlah++;
        changeQuantity = true;
        notifyListeners();
        break;
      }
    }
  }

  void decrementQuantity(String id) {
    for (var product in products ?? []) {
      if (product.id == id && product.jumlah > 1) {
        product.jumlah--;
        changeQuantity = true;
        notifyListeners();
        break;
      }
    }
  }

  Future<bool> addCart(int id) async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      String? token = await authRepository.getToken();
      final responseResult = await apiService.addProductToCart(id, token ?? '');
      if (!responseResult['error']) {
        message = 'Berhasil menambah ke keranjang';
        _resultState = ResultState.loaded;
        notifyListeners();

        return true;
      } else {
        message = 'Gagal menambah ke keranjang';
        _resultState = ResultState.error;
        notifyListeners();

        return false;
      }
    } catch (e) {
      _resultState = ResultState.error;
      message = 'Gagal menambah ke keranjang';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateQuantity(int quantity, int idCart) async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      String? token = await authRepository.getToken();
      final responseResult = await apiService.updateQuantityProductCartApi(
          quantity.toString(), idCart.toString(), token ?? '');
      if (!responseResult['error']) {
        message = 'Berhasil memperbarui kuantitas produk';
        _resultState = ResultState.loaded;
        changeQuantity = false;
        notifyListeners();

        return true;
      } else {
        message = 'Gagal memperbarui kuantitas produk';
        _resultState = ResultState.error;
        notifyListeners();

        return false;
      }
    } catch (e) {
      _resultState = ResultState.error;
      message = 'Gagal memperbarui kuantitas produk';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateAllQuantity() async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      if (products != null) {
        String? token = await authRepository.getToken();
        List<dynamic> responseResult = await Future.wait(
          products!.map((product) => apiService.updateQuantityProductCartApi(
              product.jumlah.toString(), product.id, token ?? '')),
        );

        if (responseResult.every((response) => !response['error'])) {
          message = 'Berhasil memperbarui kuantitas produk';
          _resultState = ResultState.loaded;
          changeQuantity = false;
          notifyListeners();
          return true;
        } else {
          message = 'Gagal memperbarui kuantitas produk';
          _resultState = ResultState.error;
          notifyListeners();
          return false;
        }
      } else {
        message = 'Tidak dapat memperbarui kuantitas produk';
        _resultState = ResultState.error;
        notifyListeners();

        return false;
      }
    } catch (e) {
      _resultState = ResultState.error;
      message = 'Gagal memperbarui kuantitas produk';
      notifyListeners();
      return false;
    }
  }

  Future<bool> getCarts() async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      String? token = await authRepository.getToken();
      final responseResult = await apiService.getCartsApi(token ?? '');
      products = responseResult['data']
          .map<CartModel>((product) => CartModel.fromJson(product))
          .toList();
      message = 'Berhasil mendapatkan produk';
      _resultState = ResultState.loaded;
      changeQuantity = false;
      notifyListeners();

      return products != null ? true : false;
    } catch (e) {
      _resultState = ResultState.error;
      message = 'Gagal mendapatkan produk';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteCart(int idCart) async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      String? token = await authRepository.getToken();
      final responseResult = await apiService.delKeranjang(idCart, token ?? '');
      if (!responseResult['error']) {
        message = 'Berhasil menghapus produk';
        _resultState = ResultState.loaded;
        notifyListeners();

        return true;
      } else {
        message = 'Gagal menghapus produk';
        _resultState = ResultState.error;
        notifyListeners();

        return false;
      }
    } catch (e) {
      _resultState = ResultState.error;
      message = 'Gagal menghapus produk';
      notifyListeners();
      return false;
    }
  }
}