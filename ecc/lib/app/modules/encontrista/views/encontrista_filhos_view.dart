import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/encontrista/controllers/encontrista_controller.dart';
import 'package:ecc/app/modules/encontrista/model/encontrista_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class FilhosFormView extends GetView<EncontristaController> {
  FilhosFormView({Key? key}) : super(key: key);
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
                  'Fale sobre seus filhos',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const Text(
                        'Primeiro Filho',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const FastTextField(
                        labelText: 'Informe o seu nome:',
                        name: 'nome_1',
                      ),
                      FastTextField(
                        labelText: 'Data de Nascimento',
                        inputFormatters: [configController.dateMaskFormatter],
                        name: 'nascimento_1',
                      ),
                      const FastDropdown(
                        name: 'sexo_1',
                        labelText: 'Qual o sexo?',
                        items: ['Feminino', 'Masculino'],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const Text(
                        'Segundo Filho',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const FastTextField(
                        labelText: 'Informe o seu nome:',
                        name: 'nome_2',
                      ),
                      FastTextField(
                        labelText: 'Data de Nascimento',
                        inputFormatters: [configController.dateMaskFormatter],
                        name: 'nascimento_2',
                      ),
                      const FastDropdown(
                        name: 'sexo_2',
                        labelText: 'Qual o sexo?',
                        items: ['Feminino', 'Masculino'],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const Text(
                        'Terceiro Filho',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const FastTextField(
                        labelText: 'Informe o seu nome:',
                        name: 'nome_3',
                      ),
                      FastTextField(
                        labelText: 'Data de Nascimento',
                        inputFormatters: [configController.dateMaskFormatter],
                        name: 'nascimento_3',
                      ),
                      const FastDropdown(
                        name: 'sexo_3',
                        labelText: 'Qual o sexo?',
                        items: ['Feminino', 'Masculino'],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const Text(
                        'Quarto Filho',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const FastTextField(
                        labelText: 'Informe o seu nome:',
                        name: 'nome_4',
                      ),
                      FastTextField(
                        labelText: 'Data de Nascimento',
                        inputFormatters: [configController.dateMaskFormatter],
                        name: 'nascimento_4',
                      ),
                      const FastDropdown(
                        name: 'sexo_4',
                        labelText: 'Qual o sexo?',
                        items: ['Feminino', 'Masculino'],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
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