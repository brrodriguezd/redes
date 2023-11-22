import 'package:flutter/material.dart';

TextEditingController respuestasController = TextEditingController();
String? validator_;
var respuestas = [
  ['elefante'],
  ['globo', 'bomba'],
  ['pulgar', 'dedo'],
  ['canoa', 'bote'],
  ['ventilador'],
  ['peine', 'peinilla'],
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
    validator_ = 'La respuesta era ${respuestas[idx][0]}.';
  }
  respuestasController.text = '';
  return true;
}
