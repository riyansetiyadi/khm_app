class ProductModel {
  final String? id_produk;
  final String? nama_produk;
  final String? deskripsi;
  final String? harga;
  final String? kategori;
  final String? berat;
  final String? stok;
  final String? diskon;
  final String? created_at;
  final String? foto;
  final String? updated_at;

  ProductModel({
    String? this.id_produk,
    String? this.nama_produk,
    String? this.deskripsi,
    String? this.harga,
    String? this.kategori,
    String? this.berat,
    String? this.stok,
    String? this.diskon,
    String? this.created_at,
    String? this.foto,
    String? this.updated_at,
  });

  // Factory method to create a Profile object from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id_produk: json['id_produk'],
      nama_produk: json['nama_produk'],
      deskripsi: json['deskripsi'],
      harga: json['harga'],
      kategori: json['kategori'],
      berat: json['berat'],
      stok: json['stok'],
      diskon: json['diskon'],
      created_at: json['created_at'],
      foto: json['foto'],
      updated_at: json['updated_at'],
    );
  }

  // Method to convert a Profile object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id_produk': id_produk,
      'nama_produk': nama_produk,
      'deskripsi': deskripsi,
      'harga': harga,
      'kategori': kategori,
      'berat': berat,
      'stok': stok,
      'diskon': diskon,
      'created_at': created_at,
      'foto': foto,
      'updated_at': updated_at,
    };
  }
}
