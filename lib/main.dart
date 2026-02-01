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

        /// Cor principal do tema
        colorScheme: ColorScheme.fromSeed(
          seedColor: rockBlueLight,
          primary: rockBlueLight,
        ),

        /// Tema dos chips
        chipTheme: ChipThemeData(
          backgroundColor: rockBlueLight,
          labelStyle: const TextStyle(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        /// Tema global de cards
        cardTheme: CardThemeData(
          color: Colors.black.withOpacity(0.5),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

/// Tela principal
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// Estado da tela
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      /// 🔥 Imagem de fundo ocupando toda a tela
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),

      /// Scaffold transparente para mostrar o fundo
      child: Scaffold(
        backgroundColor: Colors.transparent,

        /// AppBar com logo centralizado
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.black,
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
          centerTitle: true,
        ),

        /// Corpo da tela com Grid responsivo e rolagem manual
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // 1️⃣ Define número de colunas com base na largura
              int crossAxisCount;
              if (constraints.maxWidth >= 1200) {
                crossAxisCount = 4;
              } else if (constraints.maxWidth >= 900) {
                crossAxisCount = 3;
              } else if (constraints.maxWidth >= 600) {
                crossAxisCount = 2;
              } else {
                crossAxisCount = 1;
              }

              // 2️⃣ Calcula largura do card considerando espaçamento
              double larguraCard =
                  (constraints.maxWidth - (crossAxisCount - 1) * 14) /
                      crossAxisCount;

              // 3️⃣ Altura do card proporcional à largura (mais alta em telas pequenas)
              double alturaCard;
              if (constraints.maxWidth < 400) {
                alturaCard = larguraCard / 2.5; // iPhone SE
              } else if (constraints.maxWidth < 600) {
                alturaCard = larguraCard / 2.8; // iPhone XR / 12 Pro
              } else {
                alturaCard = larguraCard / 3; // tablets e desktop
              }

              // 4️⃣ Tamanho de fontes e chips responsivos
              double fontSizeTitulo =
              constraints.maxWidth < 400 ? 18 : 23;
              double fontSizeSubtitulo =
              constraints.maxWidth < 400 ? 12 : 16;
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

                /// Construção de cada card
                itemBuilder: (context, index) {
                  final atracao = listaAtracoes[index];

                  /// Card com efeito Glassmorphism
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white24,
                          ),
                        ),
                        padding: const EdgeInsets.all(14),

                        /// Conteúdo do card
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Nome da atração
                            Text(
                              atracao.nome,
                              style: TextStyle(
                                fontSize: fontSizeTitulo,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),

                            /// Dia do show com dia da semana
                            Text(
                              'Dia ${atracao.dia} ${atracao.diaSemana}',
                              style: TextStyle(
                                fontSize: fontSizeSubtitulo,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),

                            /// Tags da atração
                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              children: atracao.tags
                                  .map(
                                    (tag) => Chip(
                                  label: Text(
                                    tag,
                                    style: TextStyle(fontSize: chipFontSize),
                                  ),
                                  backgroundColor: rockBlueLight,
                                  labelStyle:
                                  const TextStyle(color: Colors.white),
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
} // Fecha _MyHomePageState

/// Modelo de dados da atração
class Atracao {
  final String nome;
  final int dia;
  final String diaSemana;
  final List<String> tags;

  const Atracao(this.nome, this.dia, this.diaSemana, this.tags);
}

/// Lista de atrações
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
  Atracao("João Gomes + Orquestra Brasileira", 12, "(sábado)", ["Palco Sunset"]),
];
