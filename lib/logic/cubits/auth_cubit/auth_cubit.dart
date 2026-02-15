import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/models/login_request.dart';
import '../../../../data/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final SharedPreferences _sharedPreferences;

  AuthCubit(this._authRepository, this._sharedPreferences) : super(AuthInitial());

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    try {
      final request = LoginRequest(username: username, password: password);
      final response = await _authRepository.login(request);
      
      await _sharedPreferences.setString('token', response.token);
      emit(AuthAuthenticated(response.token));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await _sharedPreferences.remove('token');
    emit(AuthInitial());
  }

  Future<void> checkAuthStatus() async {
    final token = _sharedPreferences.getString('token');
    if (token != null) {
      emit(AuthAuthenticated(token));
    } else {
      emit(AuthInitial());
    }
  }
}
