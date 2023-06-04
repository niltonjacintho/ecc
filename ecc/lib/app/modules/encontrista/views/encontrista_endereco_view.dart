import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/encontrista/controllers/encontrista_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

final EncontristaController encontristaController =
    Get.put(EncontristaController());

class EnderecoFormView extends GetView<EncontristaController> {
  EnderecoFormView({Key? key}) : super(key: key);
  final GlobalKey<FormBuilderState> formKey2 = GlobalKey<FormBuilderState>();
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
              onChanged: (values) {
                try {
                  encontristaController.encontristaModel!.endereco.logradouro =
                      values['logradouro'];
                  encontristaController.encontristaModel!.endereco.bairro =
                      values['bairro'];
                  encontristaController.encontristaModel!.endereco.cidade =
                      values['cidade'];
                  encontristaController.encontristaModel!.endereco.estado =
                      values['uf'];
                  encontristaController.encontristaModel!.endereco.complemento =
                      values['complemento'];
                } on Exception {
                  // TODO
                }
              },
              children: [
                const Text(
                  'Aonde vocês moram?',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                FastTextField(
                  labelText: 'Rua:',
                  name: 'logradouro',
                  initialValue: encontristaController
                      .encontristaModel!.endereco.logradouro,
                ),
                FastTextField(
                  labelText: 'Bairro:',
                  name: 'bairro',
                  initialValue:
                      encontristaController.encontristaModel!.endereco.bairro,
                ),
                FastTextField(
                  labelText: 'Cidade:',
                  name: 'cidade',
                  initialValue:
                      encontristaController.encontristaModel!.endereco.cidade,
                ),
                FastTextField(
                  labelText: 'Estado:',
                  name: 'uf',
                  initialValue:
                      encontristaController.encontristaModel!.endereco.estado,
                ),
                FastTextField(
                  labelText: 'Complemento:',
                  name: 'complemento',
                  initialValue: encontristaController
                      .encontristaModel!.endereco.complemento,
                ),
                FastTextField(
                  labelText: 'CEP:',
                  inputFormatters: [configController.cepMaskFormatter],
                  name: 'cep',
                  initialValue: encontristaController
                      .encontristaModel!.endereco.cep
                      .toString(),
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
