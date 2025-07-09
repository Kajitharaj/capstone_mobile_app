import 'package:capstone_mobile_app/core/services/http_api_client.dart';
import 'package:capstone_mobile_app/core/shared/model/api_response_model.dart';

class AuthService {
  final ApiClient apiClient;

  AuthService({required this.apiClient});

  Future<ApiResponseModel> login(String email, String password) async {
    try {
      final jsonResponse = await apiClient.post('/auth/login', {
        "email": email,
        "password": password,
      });

      final response = ApiResponseModel.fromJson(jsonResponse);
      if (response.success) {
        return response;
      } else {
        final errorMessage = response.error ?? 'Unknown error';
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponseModel> getCurrentUser() async {
    try {
      final jsonResponse = await apiClient.authGet('/auth/user');
      final response = ApiResponseModel.fromJson(jsonResponse);
      if (response.success) {
        return response;
      } else {
        final errorMessage = response.error ?? 'Unknown error';
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }
}
