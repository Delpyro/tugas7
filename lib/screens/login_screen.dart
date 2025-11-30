import 'package:flutter/material.dart';
import 'package:tugas9/bloc/login_bloc.dart';
import 'package:tugas9/helpers/user_info.dart';
import 'package:tugas9/widgets/warning_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    LoginBloc.login(
      email: _emailController.text,
      password: _passwordController.text,
    ).then((value) async {
      if (value.code == 200) {
        await UserInfo().setToken(value.token.toString());
        await UserInfo().setUserID(int.parse(value.userID.toString()));
        
        if (mounted) {
           Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Login gagal, email atau password salah",
          ),
        );
      }
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Login gagal, periksa koneksi internet",
        ),
      );
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.isEmpty ? "Email harus diisi" : null,
              ),
              
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? "Password harus diisi" : null,
              ),
              
              const SizedBox(height: 20),
              
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      child: const Text("Login"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) _submit();
                      },
                    ),
              
              TextButton(
                child: const Text("Belum punya akun? Registrasi"),
                onPressed: () => Navigator.pushNamed(context, '/register'),
              )
            ],
          ),
        ),
      ),
    );
  }
}