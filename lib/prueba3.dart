import 'package:flutter/material.dart';
import 'package:proyecto/prueba5.dart';

class Prueba3 extends StatefulWidget {
  final List categorias;
  final List nombres;
  final double puntaje;
  const Prueba3(
      {super.key,
      required this.puntaje,
      required this.categorias,
      required this.nombres});

  @override
  State<StatefulWidget> createState() => _Prueba3State();
}

var puntaje3 = 0;

class _Prueba3State extends State<Prueba3> {
  var correcto = false;
  var respondio = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba 3'),
      ),
      body: Center(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Ingresa la fecha de hoy, año, mes y día'),
          ),
          ElevatedButton(
            onPressed: () async {
              var fecha = await showDatePicker(
                context: context,
                currentDate: DateTime(0),
                initialDate: DateTime.utc(2000),
                firstDate: DateTime(1950),
                lastDate: DateTime(2080),
              );
              if (fecha?.day == DateTime.now().day) {
                puntaje3++;
              }
              if (fecha?.month == DateTime.now().month) {
                puntaje3++;
              }
              if (DateUtils.dateOnly(DateTime.now()) == fecha) {
                puntaje3++;
                correcto = true;
              }
              setState(() {
                respondio = true;
              });
            },
            child: const Text('Abrir el calendario'),
          ),
          respondio
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text((correcto ? 'Correcto' : 'Incorrecto')),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: const Text(
                                      'Instrucciones: ',
                                    ),
                                    content: const Text(
                                        'Hay cuatro flechas apuntando a direcciones diferentes, por favor ponlas en orden numérico siguiendo la secuencia arriba, abajo, izquierda  y derecha'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          Prueba5(
                                                            puntaje:
                                                                widget.puntaje +
                                                                    puntaje3,
                                                          )));
                                        },
                                        child: const Text('Cerrar'),
                                      )
                                    ],
                                  ));
                        },
                        child: const Text('Continuar')),
                  ],
                )
              : const Text('')
        ]),
      ),
    );
  }
}
