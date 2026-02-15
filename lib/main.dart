import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/service_locator.dart' as di;
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/product_list_screen.dart'; 
import 'logic/cubits/auth_cubit/auth_cubit.dart';
import 'logic/cubits/auth_cubit/auth_state.dart';
import 'logic/cubits/cart_cubit/cart_cubit.dart';
import 'logic/cubits/profile_cubit/profile_cubit.dart';
import 'logic/cubits/theme_cubit/theme_cubit.dart';
import 'logic/cubits/theme_cubit/theme_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthCubit>()..checkAuthStatus(),
        ),
        BlocProvider(
          create: (_) => di.sl<CartCubit>()..loadCart(1), // Assume user ID 1
        ),
        BlocProvider(
          create: (_) => di.sl<ProfileCubit>()..loadProfile(1), // Assume user ID 1
        ),
        BlocProvider(
          create: (_) => di.sl<ThemeCubit>()..loadTheme(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'FakeStore E-commerce',
            debugShowCheckedModeBanner: false,
            themeMode: themeState is ThemeDark ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              buttonTheme: ButtonThemeData(
                 buttonColor:
                  const Color(
                  0xff2F6F4E),
              ),
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.green.shade200,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(),
                filled: true,
              ),
            ),
            darkTheme: ThemeData(
              buttonTheme: ButtonThemeData(
                buttonColor:
                const Color(
                    0xff2F6F4E),
              ),
              colorScheme: ColorScheme.fromSeed(

                seedColor: Colors.deepOrangeAccent,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(),
                filled: true,
              ),
            ),
            home: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                 if (state is AuthAuthenticated) {
                   return const ProductListScreen();
                 }
                 return const LoginScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
