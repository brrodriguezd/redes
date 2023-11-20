import 'package:flutter/material.dart';
import 'package:proyecto/controller.dart';
import 'package:proyecto/prompt.dart';
import 'package:proyecto/prueba2.dart';

class Prueba extends StatefulWidget {
  const Prueba({super.key});

  @override
  State<StatefulWidget> createState() => _PruebaState();
}

//el banco de imágenes
List<Image> imgList = [
  Image.asset('images/img_1.png', fit: BoxFit.fill),
  Image.asset('images/img_2.png', fit: BoxFit.fill),
  Image.asset('images/img_3.png', fit: BoxFit.fill),
  Image.asset('images/img_4.png', fit: BoxFit.fill),
  Image.asset('images/img_5.png', fit: BoxFit.fill),
  Image.asset('images/img_6.png', fit: BoxFit.fill),
  Image.asset('images/img_7.png', fit: BoxFit.fill),
  Image.asset('images/img_8.png', fit: BoxFit.fill),
];
var categoria = [
  'animal',
  'juguete',
  'parte del cuerpo',
  'medio de transporte',
  'electrodoméstico',
  'producto cotidiano',
  'fruta',
  'artropodo'
];
var _i = 1;

class _PruebaState extends State<Prueba> {
  bool hint = false;
  @override
  void initState() {
    _i = 1;
    respuestasController.clear();
    super.initState();
  }

  @override
  void dispose() {
    respuestasController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Prueba"),
      ),
      body: Column(children: [
        imgList[_i - 1],
        Text(
          "¿Cuál es el nombre de la imagen $_i?",
          textAlign: TextAlign.justify,
        ),
        TextFormField(
          controller: respuestasController,
          autovalidateMode: AutovalidateMode.always,
          validator: (val) {
            return validator_;
          },
        ),
        !hint
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () => setState(() {
                    hint = true;
                  }),
                  child: const Text('Pista?'),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(categoria[_i - 1]),
              ),
        ElevatedButton(
            onPressed: () {
              if (validarPreguntas(_i - 1)) {
                setState(() {
                  _i++;
                  hint = false;
                });
              } else {
                errorPrompt(
                    context, 'Respuesta vacía', 'No escribio una respuesta');
              }
              if (_i == 9) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const Prueba2(),
                  ),
                );
              }
            },
            child: const Text('Siguiente'))
      ]),
    );
  }
}
