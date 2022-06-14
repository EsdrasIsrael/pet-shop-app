import 'package:flutter/cupertino.dart';

class Vet with ChangeNotifier {
  final String id;
  final String nome;
  final String telefone;
  final String email;
  final String imagem;

  Vet({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.email,
    required this.imagem,
  });

}