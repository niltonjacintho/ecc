import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecc/app/modules/noticias/noticias_edit/views/noticias_noticias_edit_view.dart';
import 'package:ecc/app/modules/noticias/view/views/noticias_view_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/noticias_noticias_list_controller.dart';

class NoticiasListView extends GetView<NoticiasListController> {
  const NoticiasListView({Key? key}) : super(key: key);
  static NoticiasListController noticiasListController =
      Get.put(NoticiasListController());
  @override
  Widget build(BuildContext context) {
    //controller.getDados();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nossas notícias'),
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
                Get.to(NoticiasEditView());
                noticiasListController.getDados();
              },
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('artigos')
            .where('pasta', isNotEqualTo: null)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar os dados do Firestore.'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              // Exiba os dados do documento
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 216, 228, 246),
                    border: Border.all(
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: data['urlImagemPrincipal'] != null
                        ? Container(
                            child: Image.network(
                            data['urlImagemPrincipal'],
                          ))
                        : const Text(
                            '.',
                          ),
                    title: Text(
                      data['titulo'] ?? '--',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(data['subtitulo'] ?? '--'),
                    onTap: () => {
                      noticiasListController.currentId.value =
                          document.id.toString(),
                      Get.to(const NoticiasView())
                    },
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
