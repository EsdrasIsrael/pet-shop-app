import 'package:flutter/material.dart';
import 'package:pet_shop_app/components/pet_card.dart';
import 'package:pet_shop_app/components/vet_card.dart';
import 'package:pet_shop_app/models/pet.dart';
import 'package:pet_shop_app/models/pet_list.dart';
import 'package:pet_shop_app/models/vet.dart';
import 'package:pet_shop_app/models/vet_list.dart';
import 'package:provider/provider.dart';

class PetShopMainPage extends StatefulWidget {
  const PetShopMainPage({ Key? key }) : super(key: key);

  @override
  State<PetShopMainPage> createState() => _PetShopMainPageState();
}

class _PetShopMainPageState extends State<PetShopMainPage> {
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<PetList>(context);
    final List<Pet> petsCadastrados = provider.pets.reversed.toList();

    final provider2 = Provider.of<VetList>(context);
    final List<Vet> vetsCadastrados = provider2.vets.reversed.toList();
    
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Pet Shop')),
        ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 40,
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0,16.0,16.0,0),
              child: Text(
                'Pets',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
          ),
          Container(
            height: 170,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: petsCadastrados[i],
                child: PetCard(),
            ),
            ),
          ),
          Container(
            width: 324,
            child: Divider(color: Colors.blue,)),
          Container(
            height: 40,
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0,16.0,16.0,0),
              child: Text(
                'Veterinários',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
          ),
          Container(
            height: 170,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: vetsCadastrados[i],
                child: VetCard(),
            ),
            ),
          ),
          ]),
    );
  }
}