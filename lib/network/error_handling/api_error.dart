class ApiError implements Exception {
  String message;
  List<dynamic>? details;

  ApiError({required this.message, this.details});

  static String get defaultErrorMessage => 'Something went wrong.';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['details'] = details;
    return data;
  }

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      message: json['message'],
      details: json['details'],
    );
  }
}
