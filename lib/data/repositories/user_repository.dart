import '../../core/network/api_client.dart';
import '../../core/utils/constants.dart';
import '../models/user.dart';

class UserRepository {
  final ApiClient _apiClient;

  UserRepository(this._apiClient);

  Future<User> getUserProfile(int id) async {
    try {
      final response = await _apiClient.get('${AppConstants.users}/$id');
      return User.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }
}
