import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubits/auth_cubit/auth_cubit.dart';
import '../../logic/cubits/auth_cubit/auth_state.dart';
import 'product_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController(text: 'mor_2314');
  final _passwordController =TextEditingController(text: '83r5^_');
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: const Color(0xffE6EFE9),
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const ProductListScreen()),
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                const Spacer(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// Title
                        const Center(
                          child: Column(
                            children: [
                              Text(
                                "E-commerce Store.",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff2F6F4E),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Enter username and Password to Login",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        /// username Label
                        const Text("Username",
                            style: TextStyle(fontSize: 14)),

                        const SizedBox(height: 8),

                        /// username Field
                        TextFormField(
                          controller: _usernameController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "username",
                            prefixIcon: const Icon(Icons.credit_card),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter username";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        /// Password Label
                        const Text("Password",
                            style: TextStyle(fontSize: 14)),

                        const SizedBox(height: 8),

                        /// Password Field
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            hintText: "********",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword =
                                  !_obscurePassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Password";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 10),

                        /// Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: Colors.black54),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// Login Button
                        state is AuthLoading
                            ? const Center(
                            child:
                            CircularProgressIndicator())
                            : SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!
                                  .validate()) {
                                HapticFeedback
                                    .mediumImpact();
                                context
                                    .read<AuthCubit>()
                                    .login(
                                  _usernameController.text,
                                  _passwordController.text,
                                );
                              }
                            },
                            style: ElevatedButton
                                .styleFrom(
                              backgroundColor:
                              const Color(
                                  0xff2F6F4E),
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(16),
                              ),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle( color: Colors.white,
                                  fontSize: 14),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// Register Text
                        Center(
                          child: RichText(
                            text: const TextSpan(
                              text:
                              "Don't have an account? ",
                              style: TextStyle(
                                  color: Colors.black54),
                              children: [
                                TextSpan(
                                  text: "Register Now",
                                  style: TextStyle(
                                    color:
                                    Color(0xff2F6F4E),
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),


              ],
            );
          },
        ),
      ),
    );
  }
}

// class _LoginScreenState extends State<LoginScreen> {
//   final _usernameController = TextEditingController(text: 'mor_2314'); // Default from FakeStoreAPI
//   final _passwordController = TextEditingController(text: '83r5^_');   // Default from FakeStoreAPI
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: BlocConsumer<AuthCubit, AuthState>(
//         listener: (context, state) {
//           if (state is AuthAuthenticated) {
//             Navigator.of(context).pushReplacement(
//               PageRouteBuilder(
//                 pageBuilder: (context, animation, secondaryAnimation) =>
//                     const ProductListScreen(),
//                 transitionsBuilder: (context, animation, secondaryAnimation, child) {
//                   return FadeTransition(opacity: animation, child: child);
//                 },
//                 transitionDuration: const Duration(milliseconds: 300),
//               ),
//             );
//           } else if (state is AuthError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Row(
//                   children: [
//                     const Icon(Icons.error_outline, color: Colors.white),
//                     const SizedBox(width: 8),
//                     Expanded(child: Text(state.message)),
//                   ],
//                 ),
//                 behavior: SnackBarBehavior.floating,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextFormField(
//                     controller: _usernameController,
//                     decoration: const InputDecoration(labelText: 'Username'),
//                     validator: (value) =>
//                         value!.isEmpty ? 'Please enter username' : null,
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _passwordController,
//                     decoration: const InputDecoration(labelText: 'Password'),
//                     obscureText: true,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Please enter password' : null,
//                   ),
//                   const SizedBox(height: 24),
//                   if (state is AuthLoading)
//                     const SizedBox(
//                       height: 48,
//                       child: Center(child: CircularProgressIndicator()),
//                     )
//                   else
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             HapticFeedback.mediumImpact();
//                             context.read<AuthCubit>().login(
//                                   _usernameController.text,
//                                   _passwordController.text,
//                                 );
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Text('Login', style: TextStyle(fontSize: 14)),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
