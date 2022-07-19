import 'dart:io';

import 'package:flutter/cupertino.dart';

class Pet with ChangeNotifier {
  final String id;
  final String nome;
  final String idade;
  final String especie;
  final File imagem;
  final String sexo;

  Pet({
    required this.id,
    required this.nome,
    required this.idade,
    required this.especie,
    required this.imagem,
    required this.sexo,
  });

}