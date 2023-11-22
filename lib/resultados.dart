import 'package:flutter/material.dart';

class Resultados extends StatelessWidget {
  final double puntaje;
  const Resultados({super.key, required this.puntaje});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultados')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            'El puntaje final es: $puntaje/13',
            textScaleFactor: 2,
          ),
        ),
      ),
    );
  }
}
