import 'package:capstone_mobile_app/core/services/http_api_client.dart';
import 'package:capstone_mobile_app/core/shared/model/api_response_model.dart';

class MovieService {
  final ApiClient apiClient;

  MovieService({required this.apiClient});

  Future<ApiResponseModel> fetchMovies() async {
    try {
      final json = await apiClient.authGet('/movies/top');
      final response = ApiResponseModel.fromJson(json);
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
