import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khm_app/models/product_model.dart';
import 'package:khm_app/service/api_service.dart';
import 'package:khm_app/utils/enum_state.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService apiService;

  ProductProvider(this.apiService) {
    _init();
  }

  ResultState _resultState = ResultState.initial;
  ResultState get state => _resultState;

  String? message;
  ProductModel? product;
  int? detailIdProduct;
  List<ProductModel>? products;
  List<ProductModel>? newProducts;
  List<ProductModel>? bestSellerProducts;

  _init() async {}

  Future<bool> getProduct(int id) async {
    _resultState = ResultState.loading;
    detailIdProduct = id;
    notifyListeners();

    try {
      final responseResult = await apiService.getProductApi(id);
      product = ProductModel.fromJson(responseResult['data'][0]);
      message = 'Berhasil mendapatkan produk';
      _resultState = ResultState.loaded;
      notifyListeners();

      return product != null ? true : false;
    } catch (e) {
      _resultState = ResultState.error;
      message = 'Gagal mendapatkan produk';
      notifyListeners();
      return false;
    }
  }

  Future<bool> getProducts(
      {String? keyword, String? filter, int? lim, int? page}) async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      final responseResult = await apiService.getProductsApi(
          keyword: keyword, filter: filter, lim: lim, page: page);
      products = responseResult['data']
          .map<ProductModel>((product) => ProductModel.fromJson(product))
          .toList();
      message = 'Berhasil mendapatkan produk';
      _resultState = ResultState.loaded;
      notifyListeners();

      return products != null ? true : false;
    } catch (e) {
      _resultState = ResultState.error;
      message = 'Gagal mendapatkan produk';
      notifyListeners();
      return false;
    }
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
      if (newProducts?.isEmpty ?? false) {
        await getProducts(lim: 5, page: 1);
        newProducts = products ?? [];
      }
      message = 'Berhasil mendapatkan produk';
      _resultState = ResultState.loaded;
      notifyListeners();

      return newProducts != null ? true : false;
    } catch (e) {
      _resultState = ResultState.error;
      message = 'Gagal mendapatkan produk';
      print(e);
      notifyListeners();
      return false;
    }
  }

  Future<bool> getBestSellerProductsHome() async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      final responseResult =
          await apiService.getBestSellerProductsApi(isBestSeller: true);
      bestSellerProducts = responseResult['data']
          .map<ProductModel>((product) => ProductModel.fromJson(product))
          .toList();
      if (bestSellerProducts?.isEmpty ?? false) {
        await getProducts(lim: 5, page: 1);
        bestSellerProducts = products ?? [];
      }
      message = 'Berhasil mendapatkan produk';
      _resultState = ResultState.loaded;
      notifyListeners();

      return bestSellerProducts != null ? true : false;
    } catch (e) {
      _resultState = ResultState.error;
      message = 'Gagal mendapatkan produk';
      notifyListeners();
      return false;
    }
  }
}
