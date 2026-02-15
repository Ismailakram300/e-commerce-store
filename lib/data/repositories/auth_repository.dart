import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../core/utils/constants.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _apiClient.post(
        AppConstants.login,
        data: request.toJson(),
      );
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }
}
