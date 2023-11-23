import 'package:flutter/material.dart';
import 'package:proyecto/prueba.dart';
import 'package:proyecto/prueba6controller.dart';
import 'package:proyecto/resultados.dart';

import 'controller.dart';

class Prueba6 extends StatefulWidget {
  final double puntaje;
  const Prueba6({super.key, this.puntaje = 0});

  @override
  State<StatefulWidget> createState() => _Prueba6State();
}

class _Prueba6State extends State<Prueba6> {
  List respuestasrespondidas = [];
  List pistas = [];
  late double puntaje;
  @override
  void initState() {
    puntaje = widget.puntaje;
    print(puntaje);
    super.initState();
  }

  @override
  void dispose() {
    prueba6Controller.dispose();
    super.dispose();
  }

  validarSustantivos(List nombres, List respuestas, List categoria) {
    for (var element in nombres) {
      if (element.contains(prueba6Controller.text.trim().toLowerCase())) {
        puntaje++;
        var borrado = categoria.removeAt(nombres.indexOf(element));
        pistas.remove(borrado);
        setState(() {
          respuestas.add(prueba6Controller.text.trim().toUpperCase());
        });
        prueba6Controller.text = '';
        return nombres.remove(element);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    prueba6Controller.addListener(
        () => validarSustantivos(respuestas, respuestasrespondidas, categoria));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba 6'),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
                'Escriba los nombres de las primeras 8 imagenes que se le mostrarón'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: prueba6Controller,
            ),
          ),
          categoria.isNotEmpty
              ? ElevatedButton(
                  onPressed: () {
                    for (var element in categoria) {
                      if (!pistas.contains(element)) {
                        setState(() {
                          pistas.add(categoria[0]);
                          puntaje -= 0.5;
                        });
                        return;
                      }
                    }
                  },
                  child: const Text('¿Pista?'))
              : ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Resultados(puntaje: puntaje))),
                  child: const Text('Continuar'),
                ),
          Text(pistas.isNotEmpty ? 'PISTAS: $pistas' : ''),
          SingleChildScrollView(
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                itemCount: respuestasrespondidas.length,
                itemBuilder: (_, int idx) {
                  final respuesta = respuestasrespondidas[
                      respuestasrespondidas.length - 1 - idx];
                  return ListTile(
                    title: Text(respuesta),
                  );
                }),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Resultados(puntaje: puntaje))),
            child: const Text('Continuar sin responder'),
          ),
        ]),
      ),
    );
  }
}
