import 'package:flutter/material.dart';
import 'package:proyecto/actividad.dart';

class Prueba3 extends StatefulWidget {
  const Prueba3({super.key});

  @override
  State<StatefulWidget> createState() => _Prueba3State();
}

class _Prueba3State extends State<Prueba3> {
  var puntaje = 0;
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
          const Text('Ingresa la fecha de hoy'),
          ElevatedButton(
            onPressed: () async {
              var fecha = await showDatePicker(
                context: context,
                currentDate: DateTime(0),
                initialDate: DateTime.utc(2000),
                firstDate: DateTime(1950),
                lastDate: DateTime(2080),
              );
              if (DateUtils.dateOnly(DateTime.now()) == fecha) {
                puntaje++;
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
                    Text((correcto ? 'Correcto' : 'Incorrecto')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const ActivityRecognitionApp(
                                          prueba: false)));
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
