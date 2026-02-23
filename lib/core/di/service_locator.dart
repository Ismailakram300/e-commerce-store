import 'package:get_it/get_it.dart';
import '../network/api_client.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/repositories/cart_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../logic/cubits/auth_cubit/auth_cubit.dart';

import '../../logic/cubits/product_cubit/product_cubit.dart';
import '../../logic/cubits/product_cubit/product_detail_cubit.dart';

import '../../logic/cubits/cart_cubit/cart_cubit.dart';

import '../../logic/cubits/profile_cubit/profile_cubit.dart';
import '../../logic/cubits/theme_cubit/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<ApiClient>(() => ApiClient());
  
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl()));
  sl.registerLazySingleton<ProductRepository>(() => ProductRepository(sl()));
  sl.registerLazySingleton<CartRepository>(() => CartRepository(sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepository(sl()));
  
  // Cubits
  sl.registerFactory<AuthCubit>(() => AuthCubit(sl(), sl()));
  sl.registerFactory<ProductCubit>(() => ProductCubit(sl()));
  sl.registerFactory<ProductDetailCubit>(() => ProductDetailCubit(sl()));
  sl.registerFactory<CartCubit>(() => CartCubit(sl(), sl()));
  sl.registerFactory<ProfileCubit>(() => ProfileCubit(sl()));
  sl.registerFactory<ThemeCubit>(() => ThemeCubit(sl()));
}
