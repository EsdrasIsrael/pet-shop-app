import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:pet_shop_app/data/dummyPet.dart';
import 'package:pet_shop_app/models/pet.dart';
import 'package:http/http.dart' as http;

class PetList with ChangeNotifier {
  final _baseUrl = 'https://pet-shop-app-cced7-default-rtdb.firebaseio.com/';

  List<Pet> _pets = dummyPets;

  List<Pet> get pets {
    return [..._pets];
  }

  Future<void> savePet(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final pet = Pet(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      nome: data['nome'] as String,
      especie: data['especie'] as String,
      sexo: data['sexo'] as String,
      idade: data['idade'] as int,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updatePet(pet);
    } else {
      return addPet(pet);
    }
  }

  Future<void> addPet(Pet pet) {
    final future = http.post(Uri.parse('$_baseUrl/pets.json'),
        body: jsonEncode({
          "nome": pet.nome,
          "idade": pet.idade,
          "especie": pet.especie,
          "imageUrl": pet.imageUrl,
          "sexo": pet.sexo,
        }));
    return future.then((response) {
      final id = jsonDecode(response.body)['nome'];

      _pets.add(Pet(
          id: id,
          nome: pet.nome,
          idade: pet.idade,
          especie: pet.especie,
          imageUrl: pet.imageUrl,
          sexo: pet.sexo
      ));
      notifyListeners();
    });
  }

  Future<void> updatePet(Pet pet) {
    final future = http.patch(Uri.parse('$_baseUrl/pets/${pet.id}.json'),
    body: jsonEncode({
          "nome": pet.nome,
          "idade": pet.idade,
          "especie": pet.especie,
          "imageUrl": pet.imageUrl,
          "sexo": pet.sexo,
        })
    );
    return future.then((response) {
      int index = _pets.indexWhere((p) => p.id == pet.id);
      if (index >= 0) {
      _pets[index] = pet;
      notifyListeners();
      }
    });
  }
}