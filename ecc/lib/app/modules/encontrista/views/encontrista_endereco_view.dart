import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/encontrista/controllers/encontrista_controller.dart';
import 'package:ecc/app/modules/encontrista/model/encontrista_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class EnderecoFormView extends GetView<EncontristaController> {
  EnderecoFormView({Key? key}) : super(key: key);
  final GlobalKey<FormBuilderState> formKey2 = GlobalKey<FormBuilderState>();
  final encontristaModel = Get.put(EncontristaModel());
  final ConfigController configController = Get.put(ConfigController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FastForm(
              formKey: formKey,
              children: [
                const Text(
                  'Aonde vocês moram?',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const FastTextField(
                  labelText: 'Rua:',
                  name: 'logradouro',
                ),
                const FastTextField(
                  labelText: 'Bairro:',
                  name: 'bairro',
                ),
                const FastTextField(
                  labelText: 'Cidade:',
                  name: 'cidade',
                ),
                const FastTextField(
                  labelText: 'Estado:',
                  name: 'uf',
                ),
                const FastTextField(
                  labelText: 'Complemento:',
                  name: 'complemento',
                ),
                FastTextField(
                  labelText: 'CEP:',
                  inputFormatters: [configController.cepMaskFormatter],
                  name: 'cep',
                ),
              ],
            ),
          ),
        ),
      ),
      //),
    );
  }
}
