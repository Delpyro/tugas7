import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); 

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      
      await prefs.setString('registered_username', _usernameController.text);
      await prefs.setString('registered_password', _passwordController.text);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registrasi Berhasil! Silakan Login.')),
        );
        Navigator.pop(context); 
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi Akun Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username Baru',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_add),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username tidak boleh kosong';
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 16),
              
              TextFormField(
                controller: _passwordController,
                obscureText: true, 
                decoration: const InputDecoration(
                  labelText: 'Password Baru',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline), 
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  if (value.length < 6) {
                    return 'Password minimal 6 karakter';
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 24),
              
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50), 
                ),
                onPressed: _register,
                child: const Text('Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}