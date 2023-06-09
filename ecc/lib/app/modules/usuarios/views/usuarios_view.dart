import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/loginuser/views/loginuser_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';

import '../controllers/usuarios_controller.dart';

class UsuariosView extends GetView<UsuariosController> {
  const UsuariosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.put(ConfigController());
    UsuariosController usuariosController = Get.put(UsuariosController());
    String usuario = '';
    String senha = '';
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FastForm(
              formKey: formKey,
              children: [
                const Text(
                  'Dados do usuário',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                FastTextField(
                  labelText: 'Informe o seu nome:',
                  autovalidateMode: AutovalidateMode.always,
                  name: 'nome',
                  validator: FormBuilderValidators.required(
                      errorText: 'Preciso mesmo do seu nome!!'),
                  onSaved: (newValue) => usuario = newValue!,
                ),
                const SizedBox(height: 20),
                FastTextField(
                  obscureText: true,
                  labelText: 'Escolha uma senha:',
                  name: 'senha',
                  onSaved: (newValue) => senha = newValue!,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: const Text('Voltar'),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        child: const Text('Cadastrar'),
                        onPressed: () async {
                          var a = formKey.currentState;
                          formKey.currentState!.save();
                          await usuariosController
                              .addUser(context, usuario, senha)
                              .then((value) async {
                            if (!value) {
                              configController.showDialog(context,
                                  texto:
                                      'Não foi possivel realizar o cadastro. Provavelmente este nome de usuário já existe!! Tente outro nome!',
                                  tipo: ArtSweetAlertType.danger);
                            } else {
                              configController.showDialog(context,
                                  texto:
                                      'Deu certo!! Vc já esta cadastrado! Faça o login agora!',
                                  tipo: ArtSweetAlertType.success);
                              await Future.delayed(const Duration(seconds: 5));
                              Get.offAll(LoginuserView());
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                //)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
