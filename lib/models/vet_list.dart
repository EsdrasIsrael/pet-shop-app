
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:pet_shop_app/data/dummyVet.dart';
import 'package:pet_shop_app/models/vet.dart';
import 'package:http/http.dart' as http;

class VetList with ChangeNotifier {
  final _baseUrl = 'https://pet-shop-app-cced7-default-rtdb.firebaseio.com/';

  List<Vet> _vets = dummyVets;

  List<Vet> get vets {
    return [..._vets];
  }

  Future<void> saveVet(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final vet = Vet(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      nome: data['name'] as String,
      telefone: data['telefone'] as String,
      email: data['email'] as String,
      imagem: data['imagem'] as String,
    );

    if (hasId) {
      return updatePet(vet);
    } else {
      return addPet(vet);
    }
  }

  Future<void> addPet(Vet vet) {
    final future = http.post(Uri.parse('$_baseUrl/veterinarios.json'),
        body: jsonEncode({
          "nome": vet.nome,
          "telefone": vet.telefone,
          "email": vet.email,
          "imagem": vet.imagem,
        }));
    return future.then((response) {
      final id = jsonDecode(response.body)['nome'];

      _vets.add(Vet(
          id: id,
          nome: vet.nome,
          telefone: vet.telefone,
          email: vet.email,
          imagem: vet.imagem,
      ));
      notifyListeners();
    });
  }

  Future<void> updatePet(Vet vet) {
    final future = http.patch(Uri.parse('$_baseUrl/veterinarios/${vet.id}.json'),
    body: jsonEncode({
          "nome": vet.nome,
          "telefone": vet.telefone,
          "email": vet.email,
          "imagem": vet.imagem,
        })
    );
    return future.then((response) {
      int index = _vets.indexWhere((p) => p.id == vet.id);
      if (index >= 0) {
      _vets[index] = vet;
      notifyListeners();
      }
    });
  }
}