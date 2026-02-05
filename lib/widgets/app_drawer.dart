import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.black),
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 180,
              ),
            ),
          ),

          _item(
            context,
            icon: Icons.home,
            title: 'Atrações',
            onTap: () {
              Navigator.pop(context); // só fecha o drawer
            },
          ),

          _item(
            context,
            icon: Icons.photo_library,
            title: 'Galeria',
            onTap: () {
              Navigator.pop(context); // fecha o drawer
              Navigator.pushNamed(context, '/galeria');
            },
          ),

          _item(
            context,
            icon: Icons.info_outline,
            title: 'Sobre o evento',
            onTap: () {
              Navigator.pop(context); // fecha o drawer
              Navigator.pushNamed(context, '/sobre');
            },
          ),
        ],
      ),
    );
  }

  Widget _item(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
      }) {
    return ListTile(
      leading: Icon(icon, color: Colors.redAccent),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }
}
