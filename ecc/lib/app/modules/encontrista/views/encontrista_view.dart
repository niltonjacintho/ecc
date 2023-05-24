import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';

import '../controllers/encontrista_controller.dart';

class EncontristaView extends GetView<EncontristaController> {
  const EncontristaView({Key? key}) : super(key: key);
  static EncontristaController encontristaController =
      Get.put(EncontristaController());

  @override
  Widget build(BuildContext context) {
    final pageformKey = GlobalKey<FormState>();
    PageController pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('EncontristaView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: PageView(
              scrollDirection: Axis.vertical,
              pageSnapping: true,
              physics: const BouncingScrollPhysics(),
              controller: pageController,
              children: <Widget>[
                widgetPessoal(context, pageformKey),
                Text(encontristaController.listaPaginas[1]['nome']!),
                Text(encontristaController.listaPaginas[2]['nome']!),
                Text(encontristaController.listaPaginas[3]['nome']!),
                Text(encontristaController.listaPaginas[4]['nome']!),
              ],
              onPageChanged: (num) {
                //pageController.jumpToPage(3);
                print("Número da página atual : $num");
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: const Text('Voltar'),
                  onPressed: () {
                    pageController.previousPage(
                        duration: const Duration(microseconds: 10),
                        curve: Curves.bounceIn);
                  },
                ),
                ElevatedButton(
                  child: const Text('Próxima'),
                  onPressed: () {
                    pageController.nextPage(
                        duration: const Duration(microseconds: 10),
                        curve: Curves.bounceIn);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget widgetPessoal(BuildContext context, GlobalKey<FormState> formkey) {
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
