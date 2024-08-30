// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillforge_ai/services/auth_service.dart';
import 'package:skillforge_ai/widgets/button.dart';
import 'package:skillforge_ai/widgets/input_field.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputField(
              controller: _emailController,
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress, onSubmitted: (_) {  },
            ),
            const SizedBox(height: 16),
            InputField(
              controller: _passwordController,
              labelText: 'Password',
              obscureText: true, onSubmitted: (_) {  },
            ),
            const SizedBox(height: 24),
            Button(
              onPressed: () async {
                final success = await authService.login(
                  _emailController.text,
                  _passwordController.text,
                );
                if (success) {
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Login failed. Please try again.')),
                  );
                }
              },
              text: 'Login',
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('Don\'t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
