import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khm_app/db/auth_repository.dart';
import 'package:khm_app/models/group_transaction_model.dart';
import 'package:khm_app/models/response_model.dart';
import 'package:khm_app/models/transaction_model.dart';
import 'package:khm_app/service/api_service.dart';
import 'package:khm_app/utils/enum_state.dart';

class TransactionProvider extends ChangeNotifier {
  final ApiService apiService;
  final AuthRepository authRepository;

  TransactionProvider(this.apiService, this.authRepository) {
    _init();
  }

  ResultState _resultState = ResultState.initial;
  ResultState get state => _resultState;

  ResponseApiModel? response;
  String? message;
  List<TransactionModel>? transactions;
  List<GroupedTransaction>? groupedTransactions;
  List<TransactionModel>? transaction;

  File? buktiTransaksi;

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
      groupedTransactions = groupAndFormatTransactions(transactions!);
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

  Future<bool> getTransactionByNota(String nota) async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      String? token = await authRepository.getToken();
      final responseResult =
          await apiService.getTransactionByNota(token ?? '', nota);
      transaction = responseResult['data']
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

  Future<bool> uploadBuktiTransaksi() async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      String? token = await authRepository.getToken();
      final responseResult = await apiService.uploadBuktiPembayaranApi(
        token ?? '',
        transaction?.first.codeNota ?? '',
        buktiTransaksi,
      );
      print("responseResult");
      response = ResponseApiModel.fromJson(responseResult);
      if (!(response?.error ?? false) &&
          (await getTransactionByNota(transaction?.first.codeNota ?? ''))) {
        message = 'Berhasil chekout produk';
        _resultState = ResultState.loaded;
        notifyListeners();

        return true;
      } else {
        message = 'Gagal chekout produk';
        _resultState = ResultState.error;
        notifyListeners();

        return false;
      }
    } catch (e) {
      print(e);
      _resultState = ResultState.error;
      message = 'Gagal mendapatkan produk';
      notifyListeners();
      return false;
    }
  }

  List<GroupedTransaction> groupAndFormatTransactions(
      List<TransactionModel> transactions) {
    Map<String, List<TransactionModel>> grouped = {};

    for (var transaction in transactions) {
      if (grouped.containsKey(transaction.idPemesanan)) {
        grouped[transaction.idPemesanan]!.add(transaction);
      } else {
        grouped[transaction.idPemesanan] = [transaction];
      }
    }

    return grouped.entries.map((entry) {
      var firstTransaction = entry.value.first;

      // Hitung total harga
      double totalHarga =
          entry.value.fold(0.0, (sum, t) => sum + double.parse(t.subHarga));

      return GroupedTransaction(
        idPemesanan: entry.key,
        codeNota: firstTransaction.codeNota,
        userId: firstTransaction.userId,
        username: firstTransaction.username,
        namaLengkap: firstTransaction.namaLengkap,
        alamatLengkap: firstTransaction.alamatLengkap,
        noTelp: firstTransaction.noTelp,
        status: firstTransaction.status,
        buktiPembayaran: firstTransaction.buktiPembayaran,
        noResi: firstTransaction.noResi,
        createdAt: firstTransaction.createdAt,
        updatedAt: firstTransaction.updatedAt,
        products: entry.value,
        totalHarga: totalHarga,
      );
    }).toList();
  }

  Future<void> pickImage() async {
    _resultState = ResultState.loading;
    notifyListeners();

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      buktiTransaksi = File(file.path!);
    }
    _resultState = ResultState.loaded;
    notifyListeners();
  }
}
