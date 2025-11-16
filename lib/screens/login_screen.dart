import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      final registeredUsername = prefs.getString('registered_username');
      final registeredPassword = prefs.getString('registered_password');

      if (registeredUsername == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Anda belum terdaftar. Silakan registrasi.')),
          );
        }
        return; 
      }

      if (_usernameController.text == registeredUsername &&
          _passwordController.text == registeredPassword) {
        
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('loggedIn_username', _usernameController.text);

        if (mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Username atau Password salah.')),
          );
        }
      }
    }
  }

  void _goToRegister() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Selamat Datang!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),

              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: _login,
                child: const Text('Login'),
              ),
              const SizedBox(height: 16),

              TextButton(
                onPressed: _goToRegister,
                child: const Text('Belum punya akun? Registrasi di sini'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}