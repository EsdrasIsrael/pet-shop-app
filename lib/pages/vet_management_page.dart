import 'package:flutter/material.dart';
import 'package:pet_shop_app/components/vet_card.dart';
import 'package:pet_shop_app/models/vet.dart';
import 'package:pet_shop_app/models/vet_list.dart';
import 'package:pet_shop_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

class VetManagementPage extends StatefulWidget {
  const VetManagementPage({ Key? key }) : super(key: key);

  @override
  State<VetManagementPage> createState() => _VetManagementPageState();
}

class _VetManagementPageState extends State<VetManagementPage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Gerenciar veterinários')),
        ),
      body: FutureBuilder(
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
                            scrollDirection: Axis.vertical,
                            itemCount: vetList.vetsCount,
                            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                              value: vetList.vetByIndex(i),
                              child: VetCard(),
                          ),
                        ),
                )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[400],
        onPressed: (){
          Navigator.of(context).pushNamed(
            AppRoutes.VET_FORM,
          );
        }, 
        child: const Icon(Icons.add,)),
    );
  }
}