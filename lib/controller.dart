import 'package:flutter/material.dart';

TextEditingController respuestasController = TextEditingController();
String? validator_;
var respuestas = [
  [
    'elefante',
  ],
  ['globo', 'bomba'],
  ['pulgar', 'dedo'],
  ['canoa'],
  ['ventilador'],
  ['peine'],
  ['pera'],
  ['araña']
];

validarPreguntas(idx) {
  if (respuestasController.text.isEmpty) {
    validator_ = '';
    return false;
  }
  if (respuestas[idx]
      .contains(respuestasController.text.trim().toLowerCase())) {
    validator_ = 'Correcto';
  } else {
    validator_ = 'Equivocado, la respuesta era ${respuestas[idx]}';
  }
  respuestasController.text = '';
  return true;
}
