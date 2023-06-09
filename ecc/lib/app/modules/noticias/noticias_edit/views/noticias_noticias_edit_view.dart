import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/noticias/model/noticias_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../controllers/noticias_noticias_edit_controller.dart';

class NoticiasEditView extends GetView<NoticiasEditController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _descricaoController = TextEditingController();
  late TextEditingController _tituloController = TextEditingController();
  late TextEditingController _subTituloController = TextEditingController();
  late TextEditingController _dataInicioController = TextEditingController();
  late TextEditingController _dataFimController = TextEditingController();

  final Rx<File?> _selectedImage = Rx<File?>(null);

  NoticiasEditView({super.key});

  // NoticiasEditView({super.key});
  static NoticiasEditController noticiasEditController =
      Get.put(NoticiasEditController()); //

  @override
  void initState() {
    //super. .initState();
    _tituloController = TextEditingController();
    _descricaoController = TextEditingController();
    _dataFimController = TextEditingController();
    _subTituloController = TextEditingController();
    _dataInicioController = TextEditingController();
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    //super.dispose();
  }

  Future<void> _salvarDados(BuildContext context, String url) async {
    noticiasEditController.noticiasModel.value = NoticiasModel();
    noticiasEditController.noticiasModel.value.noticia =
        _descricaoController.text;
    noticiasEditController.noticiasModel.value.titulo = _tituloController.text;
    noticiasEditController.noticiasModel.value.subtitulo =
        _subTituloController.text;
    noticiasEditController.noticiasModel.value.data =
        DateTime.now().toIso8601String();
    noticiasEditController.noticiasModel.value.urlImagemPrincipal = url;
    try {
      print(
          'NOTICIAS  =============== ${noticiasEditController.noticiasModel.value.toJson()}');
      await Firebase.initializeApp();
      final CollectionReference dadosRef =
          FirebaseFirestore.instance.collection('noticias');
      await dadosRef.add(noticiasEditController.noticiasModel.value.toJson());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados salvos com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar dados: $e')),
      );
      //   }
    }
  }

  void _pickPhoto() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      _selectedImage.value = File(pickedImage.path);
    }
  }

  void _pickImage() async {
    var picker = await ImagePickerWeb.getImageInfo;
    // final picker = ImagePicker();
    final pickedImage = await picker. .pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _selectedImage.value = File(pickedImage.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    ConfigController configController = Get.put(ConfigController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edição'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _tituloController,
                    decoration: const InputDecoration(labelText: 'Título'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira o título';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _subTituloController,
                    decoration: const InputDecoration(labelText: 'Sub Título'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira o sub título';
                      }
                      return null;
                    },
                  ),
                  TextField(
                    maxLines: 4,
                    controller: _descricaoController,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _pickImage,
                          child: const Text('Selecionar Foto'),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _pickPhoto,
                          child: const Text('Tirar foto'),
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    print(_selectedImage.value);
                    if (_selectedImage.value != null) {
                      return Column(
                        children: [
                          const SizedBox(height: 16.0),
                          Image.memory(pi) .file(
                            _selectedImage.value!,
                            height: 250,
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        configController
                            .uploadImageToFirebaseStorage(_selectedImage.value)
                            .then((value) async => {
                                  noticiasEditController.noticiasModel.value
                                      .urlImagemPrincipal = value,
                                  await _salvarDados(context, value)
                                });
                        Get.back();
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
