import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:infopediaflutter/api/base_api.dart';

class AuthAPI extends BaseAPI {
  Future<http.Response> register(
    String name,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    var body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation
    });
    return await http.post(
      Uri.parse('${super.baseUrl}/register'),
      headers: super.headers,
      body: body,
    );
  }

  Future<http.Response> login(
    String email,
    String password,
  ) async {
    var body = jsonEncode({'email': email, 'password': password});

    return await http.post(
      Uri.parse('${super.baseUrl}/login'),
      headers: super.headers,
      body: body,
    );
  }

  Future<http.Response> logout(int id, String token) async {
    return await http.delete(
      Uri.parse('${super.baseUrl}/logout'),
      headers: await super.headersWithToken(),
    );
  }
}
