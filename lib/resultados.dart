import 'package:flutter/material.dart';
import 'package:proyecto/actividad.dart';

class Resultados extends StatelessWidget {
  final double puntaje;
  const Resultados({super.key, required this.puntaje});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultados')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Text(
            'El puntaje final es: $puntaje/13',
            textScaleFactor: 2,
          ),
          ElevatedButton(
              onPressed: () => const ActivityRecognitionApp(),
              child: const Text('Continuar'))
        ]),
      ),
    );
  }
}
