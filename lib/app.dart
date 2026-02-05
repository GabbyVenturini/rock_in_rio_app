import 'package:app/pages/galeria_page.dart';
import 'package:app/pages/sobre_page.dart';
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';

class RockInRioApp extends StatelessWidget {
  const RockInRioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock in Rio',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const SplashScreen(),

      // 👇 ROTAS FICAM AQUI
      routes: {
        '/galeria': (context) => const GaleriaPage(),
        '/sobre': (context) => const SobrePage(),
      },
    );
  }
}


