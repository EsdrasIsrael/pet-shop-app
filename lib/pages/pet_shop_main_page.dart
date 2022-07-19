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
            child: FutureBuilder(
              future: Provider.of<PetList>(context, listen: false).loadPets(),
              builder: (ctx, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? Center(child: CircularProgressIndicator())
                  : Consumer<PetList>(
                      child: Center(
                        child: Column(children: [
                          Text('Nenhum pet cadastrado', style: TextStyle(fontSize: 18),),
                          Text('Cadastre um pet ao petshop', style: TextStyle(color: Colors.grey)),
                          Image.asset(
                            "assets/pets.png",
                            height: 125.0,
                            width: 125.0,
                          )
                        ],),
                      ),
                      builder: (context, petList, child) =>
                          petList.petsCount == 0
                              ? child!
                              : ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: petList.petsCount,
                                  itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                                    value: petList.petByIndex(i),
                                    child: PetCard(),
                                ),
                              ),
                      )
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
            height: 150,
            child: FutureBuilder(
              future: Provider.of<VetList>(context, listen: false).loadVets(),
              builder: (ctx, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? Center(child: CircularProgressIndicator())
                  : Consumer<VetList>(
                      child: Center(
                        child: Column(children: [
                          Text('Nenhum veterinário cadastrado', style: TextStyle(fontSize: 18),),
                          Text('Cadastre um veterinário ao petshop', style: TextStyle(color: Colors.grey)),
                        ]),
                      ),
                      builder: (context, vetList, child) =>
                          vetList.vetsCount == 0
                              ? child!
                              : ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: vetList.vetsCount,
                                  itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                                    value: vetList.vetByIndex(i),
                                    child: VetCard(),
                                ),
                              ),
                      )
            ),
          ),
          ]),
    );
  }
}