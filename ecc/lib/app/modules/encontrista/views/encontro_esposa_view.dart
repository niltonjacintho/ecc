import 'package:ecc/app/modules/encontrista/model/encontrista_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EsposaForm extends Container {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final EsposaForm esposa = EsposaForm();
  final encontristaModel = Get.put(EncontristaModel());

  EsposaForm({super.key});

  @override
  Widget widgetCasal(BuildContext context, GlobalKey<FormState> formkey) {
    final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

    return MaterialApp(
      home: Scaffold(
        //body: Text(encontristaController.listaPaginas[0]['nome']!),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'nome',
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderDateTimePicker(
                  name: 'nascimento',
                  decoration: const InputDecoration(labelText: 'Nascimento'),
                  inputType: InputType.date,
                  format: DateFormat('dd-MM-yyyy'),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderTextField(
                  name: 'telefone',
                  decoration:
                      const InputDecoration(labelText: 'Número de telefone'),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderTextField(
                  name: 'email',
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: FormBuilderValidators.required(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final formData = formKey.currentState!.value;
                      print(formData);
                      // Faça algo com os dados do formulário aqui
                    }
                  },
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
