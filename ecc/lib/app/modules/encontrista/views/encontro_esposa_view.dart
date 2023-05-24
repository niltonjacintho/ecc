import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/encontrista/controllers/encontrista_controller.dart';
import 'package:ecc/app/modules/encontrista/model/encontrista_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class EsposaFormView extends GetView<EncontristaController> {
  EsposaFormView({Key? key}) : super(key: key);
  final GlobalKey<FormBuilderState> formKey2 = GlobalKey<FormBuilderState>();
  final encontristaModel = Get.put(EncontristaModel());
  final ConfigController configController = Get.put(ConfigController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print('------------------------------------------------');
    return MaterialApp(
      home: Scaffold(
        //body: Text(encontristaController.listaPaginas[0]['nome']!),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FastForm(
              formKey: formKey,
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 10,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Pode nos deixar uma foto?'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // Handle gallery button press
                              // Add your logic here
                            },
                            icon: const Icon(Icons.photo_library),
                            label: const Text('Galeria'),
                          ),
                          const SizedBox(
                              width: 16), // Add some spacing between buttons
                          ElevatedButton.icon(
                            onPressed: () {
                              // Handle camera button press
                              // Add your logic here
                            },
                            icon: const Icon(Icons.camera_alt),
                            label: const Text('Foto'),
                          ),
                        ],
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
