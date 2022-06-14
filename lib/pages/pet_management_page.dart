import 'package:flutter/material.dart';
import 'package:pet_shop_app/components/pet_card.dart';
import 'package:pet_shop_app/models/pet.dart';
import 'package:pet_shop_app/models/pet_list.dart';
import 'package:pet_shop_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PetManagementPage extends StatelessWidget {
  const PetManagementPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<PetList>(context);
    final List<Pet> petsCadastrados = provider.pets;
    
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Gerenciar pets')),
        ),
      body: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: petsCadastrados.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: petsCadastrados[i],
                child: PetCard(),
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, //2 produtos por linha
                childAspectRatio: 3 / 1.5, //diemnsao de cada elemento
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
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