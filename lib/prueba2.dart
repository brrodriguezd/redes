import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proyecto/prueba2controller.dart';
import 'package:proyecto/prueba3.dart';

class Prueba2 extends StatefulWidget {
  const Prueba2({super.key});

  @override
  State<StatefulWidget> createState() => _Prueba2State();
}

class _Prueba2State extends State<Prueba2> {
  late int _counter;
  late Timer _timer;
  late String pregunta;
  List respuestas = [];

  @override
  void initState() {
    pregunta = 'vegetales';
    _counter = 60;
    sustantivosController.addListener(() => validarSustantivos(respuestas));
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    sustantivosController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const Prueba3(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Prueba 2'),
      ),
      body: Column(mainAxisSize: MainAxisSize.max, children: [
        Text(
          '$_counter',
          style: const TextStyle(fontSize: 20),
        ),
        Text('Escriba nombres de $pregunta'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: TextFormField(
            controller: sustantivosController,
            validator: (v) => val_,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              itemCount: respuestas.length,
              itemBuilder: (_, int idx) {
                final respuesta = respuestas[idx];
                return ListTile(
                  title: Text(respuesta),
                );
              }),
        ),
      ]),
    );
  }
}
