import 'package:flutter/material.dart';
// Pastikan nama package 'tugas9' ini sesuai dengan nama folder project kamu di pubspec.yaml
import 'package:tugas9/screens/splash_screen.dart';
import 'package:tugas9/screens/login_screen.dart';
import 'package:tugas9/screens/register_screen.dart';
import 'package:tugas9/screens/home_screen.dart';
import 'package:tugas9/screens/add_product_screen.dart'; // Import halaman tambah
import 'package:tugas9/screens/detail_product_screen.dart'; // Import halaman detail

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // --- TEMA TERANG (LIGHT THEME) ---
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
        centerTitle: true, // Judul otomatis di tengah
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
      
      // Floating Action Button Theme (Tombol Tambah)
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
    );

    // --- TEMA GELAP (DARK THEME) ---
    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
       appBarTheme: const AppBarTheme(
        centerTitle: true,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Pertemuan 10',

      // Pengaturan Tema
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,

      // Pengaturan Rute
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        // Rute Baru untuk CRUD Produk
        '/add_product': (context) => const AddProductScreen(),
        '/detail_product': (context) => const DetailProductScreen(),
      },
    );
  }
}