import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/pet_list.dart';
import 'package:pet_shop_app/models/vet_list.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class PetFormPage extends StatefulWidget {
  const PetFormPage({Key? key}) : super(key: key);

  @override
  State<PetFormPage> createState() => _PetFormPageState();
}

class _PetFormPageState extends State<PetFormPage> {
  
  final ImagePicker _picker = ImagePicker();
  
  File? _imageFile;

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _idadeController = TextEditingController();
  TextEditingController _especieController = TextEditingController();
  TextEditingController _sexoController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _submitForm() {
    if (_nomeController.text.isEmpty || 
    _idadeController.text.isEmpty || 
    _especieController.text.isEmpty ||
    _sexoController.text.isEmpty ||
    _imageFile == null) {
      return;
    }
    
    Provider.of<PetList>(context, listen: false)
        .addPet(_nomeController.text,
                _idadeController.text,
                _especieController.text,  
                _imageFile!, 
                _sexoController.text,);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Pet'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.check_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            imageProfile(),
            const SizedBox(height: 10),
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
              labelText: 'Nome',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _idadeController,
              decoration: const InputDecoration(
              labelText: 'Idade',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _especieController,
              decoration: const InputDecoration(
              labelText: 'Especie',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _sexoController,
              decoration: const InputDecoration(
              labelText: 'Sexo',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile != null
                ? FileImage(File(_imageFile!.path))
                : null,
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Container(
              width: 110,
              child: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
                size: 32.0,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Definir imagem",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            IconButton(
              icon: const Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
            ),
            IconButton(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    XFile imageFile = await _picker.pickImage(
      source: source,
    ) as XFile;

    if (imageFile == null) return;

    setState(() {
      _imageFile = File(imageFile.path);
    });
    Navigator.pop(context);
  }
}