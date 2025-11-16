import 'package:flutter/material.dart';
import 'package:tugas9/screens/splash_screen.dart';
import 'package:tugas9/screens/login_screen.dart';
import 'package:tugas9/screens/register_screen.dart';
import 'package:tugas9/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple, 
      ),
      useMaterial3: true, 

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white, 
        elevation: 4,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple, 
          foregroundColor: Colors.white, 
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );

    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark, 
      ),
      useMaterial3: true,
      
    );


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Tugas 7 Kreatif',

      themeMode: ThemeMode.system, 
      theme: lightTheme, 
      darkTheme: darkTheme,

      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}