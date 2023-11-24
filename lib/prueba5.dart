import 'package:flutter/material.dart';
import 'package:proyecto/prueba5controller.dart';
import 'package:proyecto/prueba6.dart';

class Prueba5 extends StatefulWidget {
  final double puntaje;
  const Prueba5({super.key, required this.puntaje});

  @override
  State<StatefulWidget> createState() => _Prueba5State();
}

class _Prueba5State extends State<Prueba5> {
  List<Column> clmList = [
    Column(
      children: [
        Image.asset(
          'images/flecha_1.png',
          fit: BoxFit.contain,
        ),
        TextFormField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: flecha1Controller,
        ),
      ],
    ),
    Column(
      children: [
        Image.asset(
          'images/flecha_2.png',
          fit: BoxFit.contain,
        ),
        TextFormField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          readOnly: true,
          controller: TextEditingController(text: '1'),
        ),
      ],
    ),
    Column(
      children: [
        Image.asset(
          'images/flecha_3.png',
          fit: BoxFit.contain,
        ),
        TextFormField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: flecha2Controller,
        ),
      ],
    ),
    Column(
      children: [
        Image.asset(
          'images/flecha_4.png',
          fit: BoxFit.contain,
        ),
        TextFormField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: flecha3Controller,
        ),
      ],
    ),
  ];
  @override
  void initState() {
    clmList.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba 5'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        'Instrucciones: ',
                      ),
                      content: const Text(
                          'Hay cuatro flechas apuntando a direcciones diferentes, por favor ponlas en orden numérico siguiendo la secuencia arriba, abajo, izquierda  y derecha'),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cerrar'),
                        )
                      ],
                    )),
            child: const Text('Instrucciones'),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 50,
              ),
              itemCount: clmList.length,
              itemBuilder: (BuildContext context, int index) => clmList[index],
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Prueba6(puntaje: widget.puntaje + validar()))),
            child: const Text('Siguiente prueba'),
          ),
        ],
      ),
    );
  }
}
