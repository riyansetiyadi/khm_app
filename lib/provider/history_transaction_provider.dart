import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khm_app/db/auth_repository.dart';
import 'package:khm_app/models/response_model.dart';
import 'package:khm_app/models/transaction_model.dart';
import 'package:khm_app/service/api_service.dart';
import 'package:khm_app/utils/enum_state.dart';

class HistoryTransactionProvider extends ChangeNotifier {
  final ApiService apiService;
  final AuthRepository authRepository;

  HistoryTransactionProvider(this.apiService, this.authRepository) {
    _init();
  }

  ResultState _resultState = ResultState.initial;
  ResultState get state => _resultState;

  ResponseApiModel? response;
  String? message;
  List<TransactionModel>? transactions;

  _init() async {}

  Future<bool> getTransactions() async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      String? token = await authRepository.getToken();
      final responseResult = await apiService.getTransactionsApi(token ?? '');
      transactions = responseResult['data']
          .map<TransactionModel>(
              (transaction) => TransactionModel.fromJson(transaction))
          .toList();
      message = 'Berhasil mendapatkan produk';
      _resultState = ResultState.loaded;
      notifyListeners();

      return transactions != null ? true : false;
    } catch (e) {
      _resultState = ResultState.error;
      message = 'Gagal mendapatkan produk';
      notifyListeners();
      return false;
    }
  }
}
