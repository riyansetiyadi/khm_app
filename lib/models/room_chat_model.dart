import 'package:khm_app/models/chat_model.dart';

class RoomChatModel {
  late String id;
  late String pasienId;
  late String dokter;
  late String adminId;
  late String createdAt;
  late String updatedAt;
  List<ChatModel>? chats;

  RoomChatModel({
    this.id = '',
    this.pasienId = '',
    this.dokter = '',
    this.adminId = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.chats,
  });

  factory RoomChatModel.fromJson(Map<String, dynamic> json) {
    return RoomChatModel(
      id: json['id'] ?? '',
      pasienId: json['pasien_id'] ?? '',
      dokter: json['dokter'] ?? '',
      adminId: json['admin_id'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      chats: (json['chats'] as List<dynamic>?)
          ?.map((chat) => ChatModel.fromJson(chat))
          .toList(),
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
      'chats': chats?.map((chat) => chat.toJson()).toList(),
    };
  }
}
