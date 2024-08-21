class TransactionModel {
  final String idPemesanan;
  final String codeNota;
  final String userId;
  final String username;
  final String namaLengkap;
  final String alamatLengkap;
  final String noTelp;
  final String produkId;
  final String produk;
  final String harga;
  final String jumlah;
  final String subHarga;
  final String status;
  final String? buktiPembayaran;
  final String? noResi;
  final DateTime createdAt;
  final DateTime updatedAt;

  TransactionModel({
    required this.idPemesanan,
    required this.codeNota,
    required this.userId,
    required this.username,
    required this.namaLengkap,
    required this.alamatLengkap,
    required this.noTelp,
    required this.produkId,
    required this.produk,
    required this.harga,
    required this.jumlah,
    required this.subHarga,
    required this.status,
    this.buktiPembayaran,
    this.noResi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      idPemesanan: json['id_pemesanan'] as String,
      codeNota: json['code_nota'] as String,
      userId: json['user_id'] as String,
      username: json['username'] as String,
      namaLengkap: json['nama_lengkap'] as String,
      alamatLengkap: json['alamat_lengkap'] as String,
      noTelp: json['no_telp'] as String,
      produkId: json['produk_id'] as String,
      produk: json['produk'] as String,
      harga: json['harga'] as String,
      jumlah: json['jumlah'] as String,
      subHarga: json['sub_harga'] as String,
      status: json['status'] as String,
      buktiPembayaran: json['bukti_pembayaran'] as String?,
      noResi: json['no_resi'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
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
      'produk_id': produkId,
      'produk': produk,
      'harga': harga,
      'jumlah': jumlah,
      'sub_harga': subHarga,
      'status': status,
      'bukti_pembayaran': buktiPembayaran,
      'no_resi': noResi,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
