class RoomChatModel {
  final String id;
  final String pasienId;
  final String dokter;
  final String adminId;
  final String createdAt;
  final String updatedAt;

  RoomChatModel({
    required this.id,
    required this.pasienId,
    required this.dokter,
    required this.adminId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoomChatModel.fromJson(Map<String, dynamic> json) {
    return RoomChatModel(
      id: json['id'] ?? '',
      pasienId: json['pasien_id'] ?? '',
      dokter: json['dokter'] ?? '',
      adminId: json['admin_id'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pasien_id': pasienId,
      'dokter': dokter,
      'admin_id': adminId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
