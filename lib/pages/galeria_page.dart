import 'package:flutter/material.dart';

class GaleriaPage extends StatelessWidget {
  const GaleriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Galeria'),
        backgroundColor: Colors.red,
      ),
      body: const Center(
        child: Text(
          'Galeria de Fotos 📸\n(em breve)',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
