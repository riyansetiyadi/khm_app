class CartModel {
  final String id;
  final String userId;
  final String username;
  final String produkId;
  final String produk;
  final String harga;
  final String diskon;
  int jumlah;
  final String subHarga;
  final String createdAt;
  final String updatedAt;
  final String idProduk;
  final String namaProduk;
  final String deskripsi;
  final String kategori;
  final String berat;
  final String stok;
  final String foto;

  CartModel({
    required this.id,
    required this.userId,
    required this.username,
    required this.produkId,
    required this.produk,
    required this.harga,
    required this.diskon,
    required this.jumlah,
    required this.subHarga,
    required this.createdAt,
    required this.updatedAt,
    required this.idProduk,
    required this.namaProduk,
    required this.deskripsi,
    required this.kategori,
    required this.berat,
    required this.stok,
    required this.foto,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      userId: json['user_id'],
      username: json['username'],
      produkId: json['produk_id'],
      produk: json['produk'],
      harga: json['harga'],
      diskon: json['diskon'],
      jumlah: int.parse(json['jumlah']), // Konversi jumlah ke int
      subHarga: json['sub_harga'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      idProduk: json['id_produk'],
      namaProduk: json['nama_produk'],
      deskripsi: json['deskripsi'],
      kategori: json['kategori'],
      berat: json['berat'],
      stok: json['stok'],
      foto: json['foto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'username': username,
      'produk_id': produkId,
      'produk': produk,
      'harga': harga,
      'diskon': diskon,
      'jumlah': jumlah.toString(), // Konversi jumlah ke String
      'sub_harga': subHarga,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'id_produk': idProduk,
      'nama_produk': namaProduk,
      'deskripsi': deskripsi,
      'kategori': kategori,
      'berat': berat,
      'stok': stok,
      'foto': foto,
    };
  }
}
