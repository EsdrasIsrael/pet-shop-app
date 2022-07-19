import 'package:flutter/material.dart';
import 'package:pet_shop_app/components/pet_card.dart';
import 'package:pet_shop_app/models/pet.dart';
import 'package:pet_shop_app/models/pet_list.dart';
import 'package:pet_shop_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PetManagementPage extends StatefulWidget {
  const PetManagementPage({ Key? key }) : super(key: key);

  @override
  State<PetManagementPage> createState() => _PetManagementPageState();
}

class _PetManagementPageState extends State<PetManagementPage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Gerenciar pets')),
        ),
      body: FutureBuilder(
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
                            scrollDirection: Axis.vertical,
                            itemCount: petList.petsCount,
                            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                              value: petList.petByIndex(i),
                              child: PetCard(),
                          ),
                        ),
                )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[400],
        onPressed: (){
          Navigator.of(context).pushNamed(
            AppRoutes.PET_FORM,
          );
        }, 
        child: Icon(Icons.add,)),
    );
  }
}