import 'dart:io';

import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/encontrista/controllers/encontrista_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EsposaFormView extends GetView<EncontristaController> {
  EsposaFormView({Key? key}) : super(key: key);
  //final GlobalKey<FormBuilderState> formKey2 = GlobalKey<FormBuilderState>();
  final ConfigController configController = Get.put(ConfigController());
  final EncontristaController encontristaController =
      Get.put(EncontristaController());

  final Rx<File?> _selectedImage = Rx<File?>(null);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void _pickPhoto() async {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.camera);

      if (pickedImage != null) {
        _selectedImage.value = File(pickedImage.path);
      }
    }

    void _pickImage() async {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        _selectedImage.value = File(pickedImage.path);
      }
    }

    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FastForm(
              formKey: formKey,
              onChanged: (values) {
                encontristaController.encontristaModel!.esposa.nome =
                    values['nome'];
                encontristaController.encontristaModel!.esposa.telefone =
                    values['telefone'];
                encontristaController.encontristaModel!.esposa.email =
                    values['email'];
                try {
                  encontristaController.encontristaModel!.esposa.nascimento =
                      DateFormat('dd/MM/yyyy').parse(values['nascimento']);
                } catch (e) {
                  encontristaController.encontristaModel!.esposa.nascimento =
                      DateTime(1900);
                }
              },
              children: [
                const Text(
                  'Dados da esposa',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                FastTextField(
                  labelText: 'Informe o seu nome:',
                  autovalidateMode: AutovalidateMode.always,
                  name: 'nome',
                  initialValue:
                      encontristaController.encontristaModel!.esposa.nome,
                  validator: FormBuilderValidators.required(
                      errorText: 'Preciso mesmo do seu nome!!'),
                ),
                FastTextField(
                  labelText: 'Telefone:',
                  inputFormatters: [configController.phoneMaskFormatter],
                  name: 'telefone',
                  initialValue:
                      encontristaController.encontristaModel!.esposa.telefone,
                ),
                FastTextField(
                  labelText: 'Informe o seu email:',
                  autovalidateMode: AutovalidateMode.always,
                  name: 'email',
                  initialValue:
                      encontristaController.encontristaModel!.esposa.email,
                  validator: FormBuilderValidators.email(
                      errorText: 'Acho que este email esta inválido'),
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
                              Image.file(
                                _selectedImage.value!,
                                height: 200,
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
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
