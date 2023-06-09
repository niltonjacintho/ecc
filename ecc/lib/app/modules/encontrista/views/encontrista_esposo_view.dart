import 'dart:io';

import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/encontrista/controllers/encontrista_controller.dart';
import 'package:ecc/app/modules/usuarios/controllers/usuarios_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EsposoFormView extends GetView<EncontristaController> {
  EsposoFormView({Key? key}) : super(key: key);

  final ConfigController configController = Get.put(ConfigController());

  final EncontristaController encontristaController =
      Get.put(EncontristaController());

  final UsuariosController usuariosController = Get.put(UsuariosController());
  final Rx<File?> _selectedImage = Rx<File?>(null);

  @override
  Widget build(BuildContext context) {
    _selectedImage.value =
        encontristaController.createImageFile(TipoArquivoPhoto.Marido);
    void _pickPhoto() async {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.camera);

      if (pickedImage != null) {
        _selectedImage.value = File(pickedImage.path);
        configController
            .uploadImageToFirebaseStorage(_selectedImage.value,
                fileName:
                    '${usuariosController.usuarioAtivo!.value.nome.trim()}-photoEsposo')
            .then((value) =>
                encontristaController.encontristaModel!.marido.photo = value);
      }
    }

    void _pickImage() async {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        _selectedImage.value = File(pickedImage.path);
        encontristaController.encontristaModel!.marido.photo = pickedImage.path;
      }
    }

    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FastForm(
              formKey: encontristaController.formKeyEsposo.value,
              onChanged: (values) {
                encontristaController.encontristaModel!.marido.nome =
                    values['nome'];
                encontristaController.encontristaModel!.marido.telefone =
                    values['telefone'];
                encontristaController.encontristaModel!.marido.email =
                    values['email'];
                try {
                  encontristaController.encontristaModel!.marido.nascimento =
                      DateFormat('dd/MM/yyyy').parse(values['nascimento']);
                } catch (e) {
                  encontristaController.encontristaModel!.marido.nascimento =
                      DateTime(1900);
                }
              },
              children: [
                const Text(
                  'Dados do marido',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                FastTextField(
                  labelText: 'Informe o seu nome:',
                  initialValue:
                      encontristaController.encontristaModel!.marido.nome,
                  autovalidateMode: AutovalidateMode.always,
                  name: 'nome',
                  validator: FormBuilderValidators.required(
                      errorText: 'Preciso mesmo do seu nome!!'),
                ),
                FastTextField(
                  labelText: 'Telefone:',
                  inputFormatters: [configController.phoneMaskFormatter],
                  name: 'telefone',
                  initialValue:
                      encontristaController.encontristaModel!.marido.telefone,
                ),
                FastTextField(
                  labelText: 'Informe o seu email:',
                  autovalidateMode: AutovalidateMode.always,
                  name: 'email',
                  validator: FormBuilderValidators.email(
                      errorText: 'Acho que este email esta inválido'),
                  initialValue:
                      encontristaController.encontristaModel!.marido.email,
                ),
                FastTextField(
                  labelText: 'Data de Nascimento',
                  inputFormatters: [configController.dateMaskFormatter],
                  name: 'nascimento',
                  initialValue: encontristaController
                      .encontristaModel!.marido.nascimento
                      .toIso8601String()
                      .split('T')
                      .first
                      .replaceAll('-', '/'),
                ),

                const SizedBox(height: 40),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Pode nos deixar uma foto?',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _pickImage();
                              },
                              icon: const Icon(Icons.photo_library),
                              label: const Text('Galeria'),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _pickPhoto();
                              },
                              icon: const Icon(Icons.camera_alt),
                              label: const Text('Foto'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () {
                        if (_selectedImage.value != null) {
                          return Column(
                            children: [
                              const SizedBox(height: 16.0),
                              Image.network(
                                  encontristaController
                                      .encontristaModel!.marido.photo,
                                  height: 200, loadingBuilder:
                                      (BuildContext context, Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              }),

                              //  ),
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),

                    //)
                  ],
                ),
                // ),
              ],
            ),
          ),
        ),
      ),
      //),
    );
  }
}
