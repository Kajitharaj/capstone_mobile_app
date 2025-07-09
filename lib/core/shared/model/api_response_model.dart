class ApiResponseModel<T> {
  final bool success;
  final T? data;
  final String? error;

  ApiResponseModel({required this.success, required this.data, this.error});

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseModel<T>(
      success: json['success'] as bool,
      data: json['data'] != null ? (json['data']) : null,
      error: json['error'] as String?,
    );
  }
}
