import 'package:ecc/app/modules/encontrista/views/encontro_esposa_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/encontrista_controller.dart';

class EncontristaView extends GetView<EncontristaController> {
  const EncontristaView({Key? key}) : super(key: key);
  static EncontristaController encontristaController =
      Get.put(EncontristaController());

  @override
  Widget build(BuildContext context) {
    EsposaFormView esposaForm = Get.put(EsposaFormView());
    PageController pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualize sues dados'),
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
                Text(encontristaController.listaPaginas[1]['nome']!),
                Text(encontristaController.listaPaginas[2]['nome']!),
                Text(encontristaController.listaPaginas[3]['nome']!),
                Text(encontristaController.listaPaginas[4]['nome']!),
              ],
              onPageChanged: (value) {
                //pageController.jumpToPage(3);
                print("Número da página atual : $value");
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
