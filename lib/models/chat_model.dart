import 'dart:convert';

class ChatModel {
  String id;
  String roomId;
  String dari;
  String dariId;
  String typeChat;
  String chat;
  DateTime createdAt;
  String updatedAt;

  ChatModel({
    required this.id,
    required this.roomId,
    required this.dari,
    required this.dariId,
    required this.typeChat,
    required this.chat,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      roomId: json['room_id'],
      dari: json['dari'],
      dariId: json['dari_id'],
      typeChat: json['type_chat'],
      chat: json['chat'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'room_id': roomId,
      'dari': dari,
      'dari_id': dariId,
      'type_chat': typeChat,
      'chat': chat,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt,
    };
  }

  static List<ChatModel> fromJsonList(List<dynamic> jsonList) {
    return List<ChatModel>.from(
      jsonList.map((json) => ChatModel.fromJson(json)),
    );
  }

  static String toJsonList(List<ChatModel> data) {
    return json.encode(
      List<dynamic>.from(data.map((x) => x.toJson())),
    );
  }
}
