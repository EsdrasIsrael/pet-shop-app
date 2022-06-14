import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/vet.dart';
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
      onTap: () => {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          margin: const EdgeInsets.all(8.0),
          child: Container(
            height: 140,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                        vet.imagem,
                        height: 140,
                        width: 140,
                        fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(vet.nome,style: TextStyle(fontSize: 24, color: Colors.blue[600]),),
                        SizedBox(height: 10),
                        Text(vet.telefone, style: TextStyle(fontSize: 13, color: Colors.grey)),
                      ],
                    ),
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
