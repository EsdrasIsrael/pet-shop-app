import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/vet.dart';
import 'package:pet_shop_app/models/vet_list.dart';
import 'package:pet_shop_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

class VetCard extends StatelessWidget {
  const VetCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final vet = Provider.of<Vet>(
      context,
      listen: false,
    );

    return InkWell(
      onTap: () => {
        Navigator.of(context).pushNamed(
          AppRoutes.VET_DETAIL,
            arguments: vet,
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
                  child: Image.network(
                        vet.imagem,
                        height: 170,
                        width: 150,
                        fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        Text(vet.nome,style: TextStyle(fontSize: 20, color: Colors.blue[600]),),
                        SizedBox(height: 10),
                        Text(vet.especializacao, style: TextStyle(fontSize: 14, color: Colors.grey)),
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
                            AppRoutes.VET_FORM,
                            arguments: vet,
                          ),
                        )
                      ),
                      PopupMenuItem(
                        child: Text('Deletar'),
                        onTap: (){
                          Provider.of<VetList>(
                            context,
                            listen: false,).removeVet(vet);
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
