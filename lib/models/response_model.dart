class ResponseApiModel {
  final bool error;
  final String message;
  final String status;
  final dynamic data;

  ResponseApiModel({
    required this.error,
    required this.message,
    required this.status,
    required this.data,
  });

  factory ResponseApiModel.fromJson(Map<String, dynamic> json) {
    return ResponseApiModel(
      error: json['error'],
      message: json['message'],
      status: json['status'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'message': message,
      'status': status,
      'data': data,
    };
  }
}
