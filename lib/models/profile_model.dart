class ProfileModel {
  final String token;

  ProfileModel({
    required this.token,
  });

  // Factory method to create a Profile object from JSON
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      token: json['token'],
    );
  }

  // Method to convert a Profile object to JSON
  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }
}
