import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/pet.dart';
import 'package:pet_shop_app/models/pet_list.dart';
import 'package:pet_shop_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PetCard extends StatelessWidget {
  const PetCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final pet = Provider.of<Pet>(
      context,
      listen: false,
    );

    return InkWell(
      onTap: () => {
        Navigator.of(context).pushNamed(
          AppRoutes.PET_DETAIL,
            arguments: pet,
        )
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          elevation: 4,
          child: Container(
            height: 170,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(File(pet.imagem.path)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pet.nome,style: TextStyle(fontSize: 20, color: Colors.blue[600]),),
                            Text("${pet.idade} anos", style: TextStyle(fontSize: 14, color: Colors.grey)),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: Colors.blue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(pet.especie, 
                              style: TextStyle(
                                fontSize: 16, 
                                color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        child: Text('Editar'),
                        onTap: () => Future(
                          () => Navigator.of(context).pushNamed(
                            AppRoutes.PET_FORM,
                            arguments: pet,
                          ),
                        )
                      ),
                      PopupMenuItem(
                        child: Text('Deletar'),
                        onTap: (){
                          Provider.of<PetList>(
                            context,
                            listen: false,).removePet(pet);
                        },
                      ),
                    ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
