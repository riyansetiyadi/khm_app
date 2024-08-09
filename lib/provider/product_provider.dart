import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khm_app/models/product_model.dart';
import 'package:khm_app/service/api_service.dart';
import 'package:khm_app/utils/enum_state.dart';

class ProductProvider extends ChangeNotifier {
  // final AuthRepository authRepository;
  final ApiService apiService;

  ProductProvider(
      // this.authRepository,
      this.apiService) {
    _init();
  }

  ResultState _resultState = ResultState.initial;
  ResultState get state => _resultState;

  String? message;
  ProductModel? product;
  List<ProductModel>? newProducts;

  _init() async {
    // profile = await authRepository.getProfile();
  }

  Future<bool> getNewProductsHome() async {
    int lim = 5;
    int page = 1;
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      final responseResult =
          await apiService.getProductsApi(lim: lim, page: page);
      newProducts = responseResult['data']
          .map<ProductModel>((product) => ProductModel.fromJson(product))
          .toList();
      message = 'Berhasil mendapatkan produk';
      _resultState = ResultState.loaded;
      notifyListeners();

      return newProducts != null ? true : false;
    } catch (e) {
      _resultState = ResultState.error;
      message = 'Gagal mendapatkan produk';
      notifyListeners();
      return false;
    }
  }
}
