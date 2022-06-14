import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/vet.dart';
import 'package:pet_shop_app/models/vet_list.dart';
import 'package:provider/provider.dart';

class VetFormPage extends StatefulWidget {
  const VetFormPage({Key? key}) : super(key: key);

  @override
  State<VetFormPage> createState() => _VetFormPageState();
}

class _VetFormPageState extends State<VetFormPage> {
  final _telefoneFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _especializacaoFocus = FocusNode();

  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

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
        final vet = arg as Vet;
        _formData['id'] = vet.id;
        _formData['nome'] = vet.nome;
        _formData['telefone'] = vet.telefone;
        _formData['email'] = vet.email;
        _formData['especializacao'] = vet.especializacao;
        _formData['imagem'] = vet.imagem;

        _imageUrlController.text = vet.imagem;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocus.dispose();
    _telefoneFocus.dispose();
    _especializacaoFocus.dispose();

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

    Provider.of<VetList>(
      context,
      listen: false,
    ).saveVet(_formData).then((value) {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Veterinário'),
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
                decoration: InputDecoration(labelText: 'Url da Imagem'),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                focusNode: _imageUrlFocus,
                controller: _imageUrlController,
                onFieldSubmitted: (_) => _submitForm(),
                onSaved: (imageUrl) =>
                    _formData['imagem'] = imageUrl ?? '',
                validator: (_imageUrl) {
                  final imageUrl = _imageUrl ?? '';
                  if (!isValidImageUrl(imageUrl)) {
                    return 'Informe uma Url válida!';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['nome']?.toString(),
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_especializacaoFocus);
                },
                onSaved: (name) => _formData['name'] = name ?? '',
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
              TextFormField(
                initialValue: _formData['especializacao']?.toString(),
                decoration: InputDecoration(
                  labelText: 'Especialização',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_telefoneFocus);
                },
                onSaved: (especializacao) => _formData['especializacao'] = especializacao ?? '',
                validator: (_especializacao) {
                  final especializacao = _especializacao ?? '';
                  if (especializacao.trim().isEmpty) {
                    return 'Especialização é obrigatória';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['telefone']?.toString(),
                decoration: InputDecoration(labelText: 'Telefone'),
                textInputAction: TextInputAction.next,
                focusNode: _telefoneFocus,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_emailFocus);
                },
                onSaved: (telefone) =>
                    _formData['telefone'] = telefone ?? '',
                validator: (_telefone) {
                  final telefone = _telefone ?? '';
                  if (telefone.trim().length < 9) {
                    return 'Telefone precisa no mínimo de 9 números.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['email']?.toString(),
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                textInputAction: TextInputAction.next,
                onSaved: (email) => _formData['email'] = email ?? '',
                validator: (_email) {
                  final email = _email ?? '';
                  if (email.trim().isEmpty) {
                    return 'Email é obrigatório';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
                    return 'Informe um email válido.';
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