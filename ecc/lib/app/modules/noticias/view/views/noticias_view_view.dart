import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scrollable_text_indicator/scrollable_text_indicator.dart';

import '../controllers/noticias_view_controller.dart';

class NoticiasView extends GetView<NoticiasViewController> {
  const NoticiasView({Key? key}) : super(key: key);

  static NoticiasViewController noticiasViewController =
      Get.put(NoticiasViewController());

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.put(ConfigController());
    configController.noticiaCurrentId.listen((value) {
      noticiasViewController.fetchDocument();
    });
    void _onItemTapped(int index) {
      if (index == 0) {
        configController.fontSize++;
      } else {
        configController.fontSize--;
      }
    }

    int selectedIndex = 0;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.text_increase),
              label: 'Aumentar letras',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.text_decrease),
              label: 'Diminuir Letras',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: configController.padraoBar(titulo: ' ', allowEdit: true),
        body: SizedBox.expand(
          child: Card(
            color: const Color.fromARGB(255, 245, 238, 215),
            elevation: 5,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: FlipCard(
                fill: Fill
                    .fillBack, // Fill the back side of the card to make in the same size as the front.
                direction: FlipDirection.VERTICAL, // default
                side: CardSide.FRONT, // The side to initially display.
                front: Card(
                  elevation: 45,
                  child: Column(
                    children: [
                      Image.network(
                        noticiasViewController
                            .noticia.value.urlImagemPrincipal!,
                        width: 300,
                        height: 300,
                      ),
                      Text(
                        noticiasViewController.noticia.value.titulo!,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        noticiasViewController.noticia.value.subtitulo!,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                back: Card(
                  elevation: 45,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          noticiasViewController.noticia.value.titulo!,
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          noticiasViewController.noticia.value.subtitulo!,
                          style: TextStyle(
                              fontSize: configController.fontSize,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () => Flexible(
                            child: FractionallySizedBox(
                              heightFactor: 0.9,
                              widthFactor: 1.0,
                              child: ScrollableTextIndicator(
                                text: Text(
                                  noticiasViewController.noticia.value.noticia!,
                                  style: TextStyle(
                                    fontSize: configController.fontSize,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //  ),
                //),
              ),
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
