import 'dart:io';

import 'package:flutter/cupertino.dart';

class Vet with ChangeNotifier {
  final String id;
  final String nome;
  final String telefone;
  final String email;
  final File imagem;
  final String especializacao;

  Vet({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.email,
    required this.imagem,
    required this.especializacao
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'imagem': imagem,
      'especializacao': especializacao,
    };
  }

  @override
  String toString() {
    return 'Vet{id: $id, nome: $nome, telefone: $telefone, email: $email, imagem: $imagem, especializacao: $especializacao}';
  }

}