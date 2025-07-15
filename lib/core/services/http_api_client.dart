// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:capstone_mobile_app/core/services/secure_storage_service.dart';
import 'package:capstone_mobile_app/core/shared/error/exception.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final http.Client httpClient;
  final AuthLocalDataSource authLocalDataSource;

  ApiClient({
    required this.baseUrl,
    http.Client? httpClient,
    required this.authLocalDataSource,
  }) : httpClient = httpClient ?? http.Client();

  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body,
  ) async {
    final url = Uri.parse('$baseUrl$path');
    try {
      final response = await httpClient.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        return throwError(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> get(String path) async {
    final url = Uri.parse('$baseUrl$path');
    try {
      final response = await httpClient.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        return throwError(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> authGet(String path) async {
    final token = await authLocalDataSource.getToken();
    final url = Uri.parse('$baseUrl$path');
    try {
      final response = await httpClient.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        return throwError(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> authPost(
    String path,
    Map<String, dynamic> body,
  ) async {
    final token = await authLocalDataSource.getToken();
    final url = Uri.parse('$baseUrl$path');
    try {
      final response = await httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        return throwError(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> authDelete(String path) async {
    final token = await authLocalDataSource.getToken();
    final url = Uri.parse('$baseUrl$path');
    try {
      final response = await httpClient.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        return throwError(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  throwError(http.Response response) {
    String? errorMessage;
    if (response.body.isNotEmpty) {
      errorMessage =
          (jsonDecode(response.body) as Map<String, dynamic>)['error'];
    }
    throw ServerException(
      errorCode: '${response.statusCode}:',
      error: errorMessage,
    );
  }
}
