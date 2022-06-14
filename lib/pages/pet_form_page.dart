import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/pet.dart';
import 'package:pet_shop_app/models/pet_list.dart';
import 'package:provider/provider.dart';

class PetFormPage extends StatefulWidget {
  const PetFormPage({Key? key}) : super(key: key);

  @override
  State<PetFormPage> createState() => _PetFormPageState();
}

class _PetFormPageState extends State<PetFormPage> {
  final _especieFocus = FocusNode();
  final _idadeFocus = FocusNode();
  final _sexoFocus = FocusNode();

  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  String selectedValue = "Macho";
  String selectedValue2 = "Cachorro";

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final pet = arg as Pet;
        _formData['id'] = pet.id;
        _formData['nome'] = pet.nome;
        _formData['idade'] = pet.idade;
        _formData['especie'] = pet.especie;
        _formData['sexo'] = pet.sexo;
        _formData['imageUrl'] = pet.imageUrl;

        _imageUrlController.text = pet.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _especieFocus.dispose();
    _idadeFocus.dispose();
    _sexoFocus.dispose();

    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<PetList>(
      context,
      listen: false,
    ).savePet(_formData).then((value) {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Pet'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.check_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                height: 150,
                width: 150,
                margin: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  image: DecorationImage(image: NetworkImage(_imageUrlController.text),) 
                ),
                alignment: Alignment.center,

              ),
              TextFormField(
                initialValue: _formData['nome']?.toString(),
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_especieFocus);
                },
                onSaved: (name) => _formData['nome'] = name ?? '',
                validator: (_name) {
                  final name = _name ?? '';
                  if (name.trim().isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  if (name.trim().length < 3) {
                    return 'Nome precisa no mínimo de 3 letras.';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                    dropdownColor: Colors.blue[400],
                    focusNode: _especieFocus,
                    onSaved: (especie) =>
                      _formData['especie'] = especie ?? '',
                    style: const TextStyle(color: Colors.black87, fontSize: 14.5),
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        filled: false,
                    ),
                    value: _formData.isEmpty ? selectedValue2 : _formData['especie']?.toString(),
                    onChanged: (String? newValue){
                      setState(() {
                        selectedValue2 = newValue!;
                      });
                    },
                    items: <DropdownMenuItem<String>>[
                      new DropdownMenuItem(
                        child: new Text('Cachorro'),
                        value: "Cachorro",
                      ),
                      new DropdownMenuItem(
                        child: new Text('Gato'),
                        value: "Gato",
                      ),
                      new DropdownMenuItem(
                        child: new Text('Ave'),
                        value: "Ave",
                      ),
                    ],
              ),

              TextFormField(
                initialValue: _formData['idade']?.toString(),
                focusNode: _idadeFocus,
                decoration: InputDecoration(
                  labelText: 'Idade',
                ),
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_especieFocus);
                },
                onSaved: (idade) => _formData['idade'] = idade ?? '',
                validator: (_idade) {
                  final idade = _idade ?? '';
                  if (idade.trim().isEmpty) {
                    return 'Idade é obrigatória';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                    dropdownColor: Colors.blue[400],
                    focusNode: _sexoFocus,
                    onSaved: (sexo) =>
                      _formData['sexo'] = sexo ?? '',
                    style: const TextStyle(color: Colors.black87, fontSize: 14.5),
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        filled: false,
                    ),
                    value: _formData.isEmpty ? selectedValue : _formData['sexo']?.toString(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: <DropdownMenuItem<String>>[
                      new DropdownMenuItem(
                        child: new Text('Macho'),
                        value: "Macho",
                      ),
                      new DropdownMenuItem(
                        child: new Text('Fêmea'),
                        value: "Fêmea",
                      ),
                    ],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Url da Imagem'),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                focusNode: _imageUrlFocus,
                controller: _imageUrlController,
                onSaved: (imageUrl) =>
                    _formData['imageUrl'] = imageUrl ?? '',
                validator: (_imageUrl) {
                  final imageUrl = _imageUrl ?? '';
                  if (!isValidImageUrl(imageUrl)) {
                    return 'Informe uma Url válida!';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}