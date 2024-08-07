// lib/models/profile.dart

class ProfileModel {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  // Factory method to create a Profile object from JSON
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
    );
  }

  // Method to convert a Profile object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
    };
  }
}
