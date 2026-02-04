import 'package:flutter/material.dart';
import 'dart:ui'; // necessário para o efeito de blur (Glassmorphism)

void main() {
  runApp(const RockInRio());
}

/// 🎨 Cor principal da identidade Rock in Rio
const rockBlueLight = Color(0xFFE51E1E);

/// Widget principal do app
class RockInRio extends StatelessWidget {
  const RockInRio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock in Rio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: rockBlueLight,
          primary: rockBlueLight,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: rockBlueLight,
          labelStyle: const TextStyle(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.black.withOpacity(0.5),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const SplashScreen(), // 👈 Splash inicia o app
    );
  }
}

/// 🔥 Splash Screen com logo
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _fadeAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0), // fade in
        weight: 65,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.0), // fade out
        weight: 35,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.1, // 🔥 começa bem pequeno
      end: 1.0,   // 🔥 cresce bastante
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MyHomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              'assets/images/logo.png',
              width: MediaQuery.of(context).size.width * 0.7, // 🔥 responsivo
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}


/// 🏠 Tela principal
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// Estado da Home
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        /// AppBar
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.black,
          centerTitle: true,
          title: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 300,
              minWidth: 100,
            ),
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),

        /// Conteúdo
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;
              if (constraints.maxWidth >= 900) {
                crossAxisCount = 3;
              } else if (constraints.maxWidth >= 600) {
                crossAxisCount = 2;
              } else {
                crossAxisCount = 1;
              }

              double larguraCard =
                  (constraints.maxWidth - (crossAxisCount - 1) * 14) /
                      crossAxisCount;

              double alturaCard =
              constraints.maxWidth < 600 ? larguraCard / 2.6 : larguraCard / 3;

              double fontSizeTitulo = constraints.maxWidth < 400 ? 18 : 23;
              double fontSizeSubtitulo = constraints.maxWidth < 400 ? 12 : 16;
              double chipFontSize = constraints.maxWidth < 400 ? 10 : 14;

              return GridView.builder(
                itemCount: listaAtracoes.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: larguraCard / alturaCard,
                ),
                itemBuilder: (context, index) {
                  final atracao = listaAtracoes[index];

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              atracao.nome,
                              style: TextStyle(
                                fontSize: fontSizeTitulo,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Dia ${atracao.dia} ${atracao.diaSemana}',
                              style: TextStyle(
                                fontSize: fontSizeSubtitulo,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              children: atracao.tags
                                  .map(
                                    (tag) => Chip(
                                  label: Text(
                                    tag,
                                    style:
                                    TextStyle(fontSize: chipFontSize),
                                  ),
                                ),
                              )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

/// 🎵 Modelo da atração
class Atracao {
  final String nome;
  final int dia;
  final String diaSemana;
  final List<String> tags;

  const Atracao(this.nome, this.dia, this.diaSemana, this.tags);
}

/// 🎤 Lista de atrações
const listaAtracoes = [
  Atracao("Miley Cyrus", 4, "(sexta-feira)", ["Rumor", "Palco Mundo"]),
  Atracao("SZA", 4, "(sexta-feira)", ["Rumor", "Palco Sunset"]),
  Atracao("BLACKPINK", 5, "(sábado)", ["Rumor", "Palco Mundo"]),
  Atracao("Justin Bieber", 5, "(sábado)", ["Rumor", "Palco Sunset"]),
  Atracao("Pearl Jam", 6, "(domingo)", ["Rumor", "Palco Mundo"]),
  Atracao("Elton John", 7, "(segunda-feira)", ["Palco Mundo"]),
  Atracao("Gilberto Gil", 7, "(segunda-feira)", ["Palco Mundo"]),
  Atracao("Stray Kids", 11, "(sexta-feira)", ["Palco Mundo"]),
  Atracao("Jamiroquai", 11, "(sexta-feira)", ["Palco Sunset"]),
  Atracao("Maroon 5", 12, "(sábado)", ["Palco Mundo"]),
  Atracao("Demi Lovato", 12, "(sábado)", ["Palco Mundo"]),
  Atracao("Mumford & Sons", 12, "(sábado)", ["Palco Sunset"]),
  Atracao(
    "João Gomes + Orquestra Brasileira",
    12,
    "(sábado)",
    ["Palco Sunset"],
  ),
];
