import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/pet.dart';
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
      onTap: () => {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          elevation: 4,
          margin: const EdgeInsets.all(8),
          child: Container(
            height: 170,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                        pet.imageUrl,
                        height: 170,
                        width: 150,
                        fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(pet.nome,style: TextStyle(fontSize: 24, color: Colors.blue[600]),),
                      Text("${pet.idade} anos", style: TextStyle(fontSize: 17, color: Colors.grey)),
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
                PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        child: Text('Editar'),
                        onTap: (){},
                      ),
                      PopupMenuItem(
                        child: Text('Deletar'),
                        onTap: (){},
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
