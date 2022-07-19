import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:pet_shop_app/models/pet.dart';
import 'package:http/http.dart' as http;
import 'package:pet_shop_app/utils/db_util.dart';

class PetList with ChangeNotifier {
  final _baseUrl = 'https://pet-shop-app-cced7-default-rtdb.firebaseio.com/';

  List<Pet> _pets = [];
  
  List<Pet> get pets {
    return [..._pets];
  }

  int get petsCount {
    return _pets.length;
  }

  Pet petByIndex(int index) {
    return _pets[index];
  }

  Future<void> loadPets() async {
    final dataList = await DbUtil.getData('pets');
    _pets = dataList
        .map(
          (item) => Pet(
            id: item['id'],
            nome: item['nome'],
            idade: item['idade'],
            especie: item['especie'],
            imagem: File(item['imagem']),
            sexo: item['sexo'],
          ),
        )
        .toList();
    notifyListeners();
  }

  void addPet(String nome, String idade, String especie, File imagem, String sexo) async {

    final newPet = Pet(
          id: Random().nextInt(10000).toString(),
          nome: nome,
          idade: idade,
          especie: especie,
          imagem: imagem,
          sexo: sexo
    );    
    
    _pets.add(newPet);
    DbUtil.insert('pets', {
      'id': newPet.id,
      'nome': newPet.nome,
      'idade': newPet.idade,
      'especie': newPet.especie,
      'imagem': newPet.imagem.path,
      'sexo': newPet.sexo,
    });
    notifyListeners();
  }

  void removePet(Pet pet) {
    int index = _pets.indexWhere((p) => p.id == pet.id);

    if (index >= 0) {
      _pets.removeWhere((p) => p.id == pet.id);
      DbUtil.delete('pets', int.parse(pet.id));
      notifyListeners();
    }
  }
}