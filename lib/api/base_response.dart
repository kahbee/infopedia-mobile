class BaseResponse {
  BaseResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  final bool success;
  final dynamic data;
  final String message;

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      success: json["success"],
      data: json["data"],
      message: json["message"],
    );
  }
}
