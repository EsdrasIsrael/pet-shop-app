import 'package:flutter/cupertino.dart';

class Pet with ChangeNotifier {
  final String id;
  final String nome;
  final String idade;
  final String especie;
  final String imageUrl;
  final String sexo;

  Pet({
    required this.id,
    required this.nome,
    required this.idade,
    required this.especie,
    required this.imageUrl,
    required this.sexo,
  });

}