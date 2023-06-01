import 'dart:io';

import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/encontrista/controllers/encontrista_controller.dart';
import 'package:ecc/app/modules/encontrista/model/encontrista_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EsposaFormView extends GetView<EncontristaController> {
  EsposaFormView({Key? key}) : super(key: key);
  //final GlobalKey<FormBuilderState> formKey2 = GlobalKey<FormBuilderState>();
  final encontristaModel = Get.put(EncontristaModel());
  final ConfigController configController = Get.put(ConfigController());
  EncontristaController encontristaController =
      Get.put(EncontristaController());

  final Rx<File?> _selectedImage = Rx<File?>(null);

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
              formKey: encontristaController.formKey,
              children: [
                const Text(
                  'Dados da esposa',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                FastTextField(
                  labelText: 'Informe o seu nome:',
                  autovalidateMode: AutovalidateMode.always,
                  name: 'nome',
                  validator: FormBuilderValidators.required(
                      errorText: 'Preciso mesmo do seu nome!!'),
                ),
                FastTextField(
                  labelText: 'Telefone:',
                  inputFormatters: [configController.phoneMaskFormatter],
                  name: 'telefone',
                ),
                FastTextField(
                  labelText: 'Informe o seu email:',
                  autovalidateMode: AutovalidateMode.always,
                  name: 'email',
                  validator: FormBuilderValidators.email(
                      errorText: 'Acho que este email esta inválido'),
                ),
                FastTextField(
                  labelText: 'Data de Nascimento',
                  inputFormatters: [configController.dateMaskFormatter],
                  name: 'nascimento',
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
