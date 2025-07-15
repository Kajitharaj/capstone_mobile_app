import 'package:capstone_mobile_app/core/services/http_api_client.dart';
import 'package:capstone_mobile_app/core/shared/model/api_response_model.dart';

class WishListService {
  final ApiClient apiClient;

  WishListService({required this.apiClient});

  Future<ApiResponseModel> getWishList() async {
    try {
      final json = await apiClient.authGet('/wishlists/getWishList');
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

  Future<ApiResponseModel> deleteWishList(int? id) async {
    try {
      final json = await apiClient.authDelete('/wishlists/deleteWishList/$id');
      final response = ApiResponseModel.fromJson(json);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
