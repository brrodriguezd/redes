import 'package:flutter/cupertino.dart';

var sustantivos = [
  'alcachofa',
  'cebolla roja',
  'espinaca',
  'batata',
  'tomate',
  'ñame',
  'espárrago',
  'zanahoria',
  'coliflor',
  'apio',
  'chayote',
  'brotes de bambú',
  'brotes de soja',
  'cebolla',
  'puerro',
  'lechuga',
  'champiñón',
  'cebolla',
  'chirivía',
  'judías',
  'remolacha',
  'pimiento',
  'patata',
  'calabaza',
  'achicoria',
  'rábano',
  'pimiento',
  'brécol',
  'coles',
  'repollo',
  'nopal',
  'berza',
  'maíz',
  'pepino',
  'berenjena',
  'escarola',
  'escarola',
  'ajo',
  'judías verdes',
  'guisante',
  'lombarda',
  'pimiento rojo',
  'calabaza amarilla',
  'calabacín',
];
TextEditingController sustantivosController = TextEditingController();
int puntaje = 0;
String? val_;
validarSustantivos(List respuestas) {
  if (sustantivos.contains(sustantivosController.text.trim().toLowerCase())) {
    puntaje++;
    val_ = 'puntaje $puntaje';
    respuestas.add(sustantivosController.text.trim().toUpperCase());
    sustantivos.remove(sustantivosController.text.trim().toLowerCase());
    sustantivosController.text = '';
  }
}
