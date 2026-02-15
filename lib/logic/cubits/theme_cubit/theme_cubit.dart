import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences _sharedPreferences;
  static const String _themeKey = 'theme_mode';

  ThemeCubit(this._sharedPreferences) : super(const ThemeLight());

  Future<void> loadTheme() async {
    final isDark = _sharedPreferences.getBool(_themeKey) ?? false;
    emit(isDark ? const ThemeDark() : const ThemeLight());
  }

  Future<void> toggleTheme() async {
    final isDark = state is ThemeDark;
    await _sharedPreferences.setBool(_themeKey, !isDark);
    emit(isDark ? const ThemeLight() : const ThemeDark());
  }
}
