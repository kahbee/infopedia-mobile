class LoginResponse {
  LoginResponse({required this.token, required this.name});

  final String token;
  final String name;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json["token"],
      name: json["name"],
    );
  }
}
