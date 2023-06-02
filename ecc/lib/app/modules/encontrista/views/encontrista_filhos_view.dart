import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/encontrista/controllers/encontrista_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FilhosFormView extends GetView<EncontristaController> {
  FilhosFormView({Key? key}) : super(key: key);
  final GlobalKey<FormBuilderState> formKey2 = GlobalKey<FormBuilderState>();
  final ConfigController configController = Get.put(ConfigController());
  final formKey = GlobalKey<FormState>();
  final EncontristaController encontristaController =
      Get.put(EncontristaController());

  void fillFilhos(
      String fieldNome, String fieldNomeValue, String fieldNascimentoValue) {
    var i = double.tryParse(fieldNome.substring(fieldNome.length - 1)) != null
        ? int.parse(fieldNome.substring(fieldNome.length - 1))
        : 0;
    if (i != 0) {
      i--;
      encontristaController.encontristaModel!.filhos[i].nome = fieldNomeValue;
      try {
        encontristaController.encontristaModel!.filhos[i].dataNascimento =
            DateFormat('dd/MM/yyyy').parse(fieldNascimentoValue);
      } catch (e) {
        encontristaController.encontristaModel!.filhos[i].dataNascimento =
            DateTime(1900);
      }
    }
  }

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
                fillFilhos('nome_1', values['nome_1'], values['nascimento_1']);
                fillFilhos('nome_2', values['nome_2'], values['nascimento_2']);
                fillFilhos('nome_3', values['nome_3'], values['nascimento_3']);
                fillFilhos('nome_4', values['nome_4'], values['nascimento_4']);
              },
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
