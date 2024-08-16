class ResponseApiModel {
  final bool error;
  final String message;
  final String status;

  ResponseApiModel({
    required this.error,
    required this.message,
    required this.status,
  });

  factory ResponseApiModel.fromJson(Map<String, dynamic> json) {
    return ResponseApiModel(
      error: json['error'],
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'message': message,
      'status': status,
    };
  }
}
