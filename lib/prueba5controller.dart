import 'package:flutter/cupertino.dart';

TextEditingController flecha1Controller = TextEditingController();
TextEditingController flecha2Controller = TextEditingController();
TextEditingController flecha3Controller = TextEditingController();

validar() {
  double puntaje = 0;
  if (flecha1Controller.text.trim() == '4') {
    puntaje++;
  }
  if (flecha2Controller.text.trim() == '3') {
    puntaje++;
  }
  if (flecha3Controller.text.trim() == '2') {
    puntaje++;
  }
  return puntaje;
}
