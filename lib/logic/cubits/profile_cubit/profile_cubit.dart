import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/user_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository _userRepository;

  ProfileCubit(this._userRepository) : super(ProfileInitial());

  Future<void> loadProfile(int userId) async {
    emit(ProfileLoading());
    try {
      final user = await _userRepository.getUserProfile(userId);
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
