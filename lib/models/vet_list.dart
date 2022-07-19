import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:pet_shop_app/models/vet.dart';
import 'package:http/http.dart' as http;
import 'package:pet_shop_app/utils/db_util.dart';
import 'package:sqflite/sqlite_api.dart';

class VetList with ChangeNotifier {
  final _baseUrl = 'https://pet-shop-app-cced7-default-rtdb.firebaseio.com/';

  List<Vet> _vets = [];

  List<Vet> get vets {
    return [..._vets];
  }

  int get vetsCount {
    return _vets.length;
  }

  Vet vetByIndex(int index) {
    return _vets[index];
  }

  Future<void> loadVets() async {
    final dataList = await DbUtil.getData('vets');
    _vets = dataList
        .map(
          (item) => Vet(
            id: item['id'],
            nome: item['nome'],
            telefone: item['telefone'],
            email: item['email'],
            imagem: File(item['imagem']),
            especializacao: item['especializacao'],
          ),
        )
        .toList();
    notifyListeners();
  }

  void addVet(String nome, String telefone, String email, File imagem, String especializacao) async {

    final newVet = Vet(
          id: Random().nextInt(10000).toString(),
          nome: nome,
          telefone: telefone,
          email: email,
          imagem: imagem,
          especializacao: especializacao
    );    
    
    _vets.add(newVet);
    DbUtil.insert('vets', {
      'id': newVet.id,
      'nome': newVet.nome,
      'telefone': newVet.telefone,
      'email': newVet.email,
      'imagem': newVet.imagem.path,
      'especializacao': newVet.especializacao,
    });
    notifyListeners();
  }

  void removeVet(Vet vet) {
    int index = _vets.indexWhere((p) => p.id == vet.id);

    if (index >= 0) {
      _vets.removeWhere((p) => p.id == vet.id);
      DbUtil.delete('vets', int.parse(vet.id));
      notifyListeners();
    }
  }
}