import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/encontrista/controllers/encontrista_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CasamentoFormView extends GetView<EncontristaController> {
  CasamentoFormView({Key? key}) : super(key: key);
  final GlobalKey<FormBuilderState> formKey2 = GlobalKey<FormBuilderState>();

  final ConfigController configController = Get.put(ConfigController());
  final formKey = GlobalKey<FormState>();

  final EncontristaController encontristaController =
      Get.put(EncontristaController());

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
                encontristaController.encontristaModel!.casamento.igreja =
                    values['igreja'];
                try {
                  encontristaController.encontristaModel!.casamento.data =
                      DateFormat('dd/MM/yyyy').parse(values['data']);
                } catch (e) {
                  encontristaController.encontristaModel!.casamento.data =
                      DateTime(1900);
                }
              },
              children: [
                const Text(
                  'Dados do seu casamento',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const FastTextField(
                  labelText: 'Em qual igreja vcs se casaram::',
                  autovalidateMode: AutovalidateMode.always,
                  name: 'igreja',
                ),
                FastTextField(
                  labelText: 'Que dia foi?',
                  inputFormatters: [configController.dateMaskFormatter],
                  name: 'data',
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
