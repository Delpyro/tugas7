import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.remove('isLoggedIn');
    await prefs.remove('loggedIn_username');

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (Route<dynamic> route) => false, 
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, 
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Tugas 7 Kreatif'),
            accountEmail: Text('Menu Navigasi'),
            currentAccountPicture: CircleAvatar(
              child: FlutterLogo(size: 42.0),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Halaman Utama'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          
          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              _logout(context);
            },
          ),
        ],
      ),
    );
  }
}