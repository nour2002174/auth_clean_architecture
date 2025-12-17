import 'package:auth_clean_architecture/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Welcome ${state.user.name}!")),
            );
            Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LoginPage()),
                    );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                TextField(
  controller: confirmPasswordController,
  decoration: InputDecoration(labelText: "Confirm Password"),
  obscureText: true,
),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (passwordController.text != confirmPasswordController.text) {

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Passwords do not match")),
  );
  return;
}

                    BlocProvider.of<AuthBloc>(context).add(
                      SignupEvent(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                  },
                  child: Text("Signup"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
