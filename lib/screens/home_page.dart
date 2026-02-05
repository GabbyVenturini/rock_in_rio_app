import 'package:flutter/material.dart';
import 'dart:ui';

import '../data/lista_atracoes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

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

              final larguraCard =
                  (constraints.maxWidth - (crossAxisCount - 1) * 14) /
                      crossAxisCount;

              final alturaCard =
              constraints.maxWidth < 600 ? larguraCard / 2.6 : larguraCard / 3;

              final fontSizeTitulo = constraints.maxWidth < 400 ? 18.0 : 23.0;
              final fontSizeSubtitulo = constraints.maxWidth < 400 ? 12.0 : 16.0;
              final chipFontSize = constraints.maxWidth < 400 ? 10.0 : 14.0;

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