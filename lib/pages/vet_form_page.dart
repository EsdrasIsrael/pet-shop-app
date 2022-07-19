import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/vet.dart';
import 'package:pet_shop_app/models/vet_list.dart';
import 'package:pet_shop_app/utils/db_util.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class VetFormPage extends StatefulWidget {
  const VetFormPage({Key? key}) : super(key: key);

  @override
  State<VetFormPage> createState() => _VetFormPageState();
}

class _VetFormPageState extends State<VetFormPage> {
  
  final ImagePicker _picker = ImagePicker();
  
  File? _imageFile;

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _especializacaoController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _submitForm() {
    if (_nomeController.text.isEmpty || 
    _especializacaoController.text.isEmpty || 
    _telefoneController.text.isEmpty ||
    _emailController.text.isEmpty ||
    _imageFile == null) {
      return;
    }
    
    Provider.of<VetList>(context, listen: false)
        .addVet(_nomeController.text,
                _telefoneController.text,
                _emailController.text,  
                _imageFile!, 
                _especializacaoController.text,);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Veterinário'),
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
              controller: _especializacaoController,
              decoration: const InputDecoration(
              labelText: 'Especialização',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _telefoneController,
              decoration: const InputDecoration(
              labelText: 'Telefone',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
              labelText: 'Email',
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