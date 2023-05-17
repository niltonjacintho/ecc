import 'package:ecc/app/modules/config/controllers/config_controller.dart';
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
    ConfigController configController = Get.put(ConfigController());
    noticiasViewController.fetchDocument();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: configController.padraoBar(titulo: ' ', allowEdit: true),
      body: SizedBox.expand(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: configController.appBarBackGroundImage,
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Image.network(
                  noticiasViewController.noticia.value.urlImagemPrincipal!,
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
                Padding(
                  padding: const EdgeInsets.only(
                      top: 12, bottom: 10, left: 8, right: 8),
                  child: SizedBox(
                    height: 180,
                    child: ScrollableTextIndicator(
                      text: Text(
                        noticiasViewController.noticia.value.noticia!,
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    //  ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      //  ),
    );
  }
}
