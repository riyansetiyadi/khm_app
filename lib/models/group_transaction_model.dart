import 'package:khm_app/models/transaction_model.dart';

class GroupedTransaction {
  final String idPemesanan;
  final String codeNota;
  final String userId;
  final String username;
  final String namaLengkap;
  final String alamatLengkap;
  final String noTelp;
  final String status;
  final String? buktiPembayaran;
  final String? noResi;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<TransactionModel> products;
  final double totalHarga;

  GroupedTransaction({
    required this.idPemesanan,
    required this.codeNota,
    required this.userId,
    required this.username,
    required this.namaLengkap,
    required this.alamatLengkap,
    required this.noTelp,
    required this.status,
    this.buktiPembayaran,
    this.noResi,
    required this.createdAt,
    required this.updatedAt,
    required this.products,
    required this.totalHarga,
  });

  factory GroupedTransaction.fromJson(Map<String, dynamic> json) {
    return GroupedTransaction(
      idPemesanan: json['id_pemesanan'],
      codeNota: json['code_nota'],
      userId: json['user_id'],
      username: json['username'],
      namaLengkap: json['nama_lengkap'],
      alamatLengkap: json['alamat_lengkap'],
      noTelp: json['no_telp'],
      status: json['status'],
      buktiPembayaran: json['bukti_pembayaran'],
      noResi: json['no_resi'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      products: (json['products'] as List<dynamic>)
          .map(
              (item) => TransactionModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalHarga: json['total_harga'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pemesanan': idPemesanan,
      'code_nota': codeNota,
      'user_id': userId,
      'username': username,
      'nama_lengkap': namaLengkap,
      'alamat_lengkap': alamatLengkap,
      'no_telp': noTelp,
      'status': status,
      'bukti_pembayaran': buktiPembayaran,
      'no_resi': noResi,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'products': products.map((product) => product.toJson()).toList(),
      'total_harga': totalHarga,
    };
  }
}
