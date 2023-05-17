import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecc/app/modules/noticias/noticias_edit/views/noticias_noticias_edit_view.dart';
import 'package:ecc/app/modules/noticias/noticias_list/controllers/noticias_noticias_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigController extends GetxController {
  //TODO: Implement ConfigController

  final count = 0.obs;

  void increment() => count.value++;
  RxString noticiaCurrentId = '4444'.obs;

  AssetImage appBarBackGroundImage =
      const AssetImage('assets/images/fundoGeral.jpg');

  NoticiasListController noticiasListController =
      Get.put(NoticiasListController());

  final TextStyle estiloTitulo = const TextStyle(
      fontSize: 94, fontWeight: FontWeight.w900, color: Colors.black26);

  AppBar padraoBar({String titulo = '', bool allowEdit = true}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: const Color.fromARGB(255, 1, 14, 26),
      elevation: 0,
      title: Text(
        titulo,
        style: const TextStyle(
            color: Color.fromARGB(255, 1, 14, 26), fontSize: 26),
      ),
      centerTitle: false,
      actions: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.blue,
            ),
            onPressed: () {
              if (allowEdit) {
                Get.to(NoticiasEditView());
                noticiasListController.getDados();
              }
            },
          ),
        ),
      ],
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocumentById(
      String collection, String documentId) async {
    print('$collection  and $documentId  and $noticiaCurrentId ');
    final DocumentReference<Map<String, dynamic>> documentRef =
        FirebaseFirestore.instance.collection(collection).doc(documentId);
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await documentRef.get();
    return snapshot;
  }
}
