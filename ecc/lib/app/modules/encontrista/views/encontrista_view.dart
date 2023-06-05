import 'package:ecc/app/modules/config/controllers/httpImport_controller.dart';
import 'package:ecc/app/modules/encontrista/views/encontrista_casamento_view.dart';
import 'package:ecc/app/modules/encontrista/views/encontrista_endereco_view.dart';
import 'package:ecc/app/modules/encontrista/views/encontrista_esposo_view.dart';
import 'package:ecc/app/modules/encontrista/views/encontrista_filhos_view.dart';
import 'package:ecc/app/modules/encontrista/views/encontro_esposa_view.dart';
import 'package:ecc/app/modules/usuarios/controllers/usuarios_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/encontrista_controller.dart';

class EncontristaView extends GetView<EncontristaController> {
  const EncontristaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EncontristaController encontristaController =
        Get.put(EncontristaController());

    HttpImportController httpImportController = Get.put(HttpImportController());
    EsposaFormView esposaForm = Get.put(EsposaFormView());
    EsposoFormView esposoForm = Get.put(EsposoFormView());
    CasamentoFormView casamentoFormView = Get.put(CasamentoFormView());
    EnderecoFormView enderecoFormView = Get.put(EnderecoFormView());
    FilhosFormView filhosFormView = Get.put(FilhosFormView());
    PageController pageController = PageController();
    UsuariosController usuariosController = Get.put(UsuariosController());
    encontristaController.get(usuariosController.usuarioAtivo!.value.nome);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            ' - ${usuariosController.usuarioAtivo!.value.nome} Atualize sues dados '),
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
                esposaForm,
                esposoForm,
                casamentoFormView,
                enderecoFormView,
                filhosFormView,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        encontristaController.listaPaginas[4]['nome']!,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  ],
                )
              ],
              onPageChanged: (value) {
                encontristaController.gravar(); //pageController.jumpToPage(3);
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
}
