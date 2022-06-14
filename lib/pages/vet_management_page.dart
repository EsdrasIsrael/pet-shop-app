import 'package:flutter/material.dart';
import 'package:pet_shop_app/components/vet_card.dart';
import 'package:pet_shop_app/models/vet.dart';
import 'package:pet_shop_app/models/vet_list.dart';
import 'package:pet_shop_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

class VetManagementPage extends StatelessWidget {
  const VetManagementPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<VetList>(context);
    final List<Vet> veterinarios = provider.vets;
    
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Gerenciar veterinários')),
        ),
      body: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: veterinarios.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: veterinarios[i],
                child: VetCard(),
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
            AppRoutes.VET_FORM,
          );
        }, 
        child: Icon(Icons.add,)),
    );
  }
}