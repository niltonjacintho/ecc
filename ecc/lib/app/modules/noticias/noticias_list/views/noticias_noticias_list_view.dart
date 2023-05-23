import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/noticias/noticias_edit/views/noticias_noticias_edit_view.dart';
import 'package:ecc/app/modules/noticias/view/controllers/noticias_view_controller.dart';
import 'package:ecc/app/modules/noticias/view/views/noticias_view_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/noticias_noticias_list_controller.dart';

// ignore: must_be_immutable
class NoticiasListView extends GetView<NoticiasListController> {
  NoticiasListView({Key? key}) : super(key: key);
  ConfigController configController = Get.put(ConfigController());
  NoticiasListController noticiasListController =
      Get.put(NoticiasListController());
  NoticiasViewController noticiasViewController =
      Get.put(NoticiasViewController());
  @override
  Widget build(BuildContext context) {
    //controller.getDados();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: const Color.fromARGB(255, 1, 14, 26),
        elevation: 0,
        title: const Text(
          'Nossas notícias===',
          style: TextStyle(color: Color.fromARGB(255, 1, 14, 26), fontSize: 26),
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
                Get.to(NoticiasEditView());
                noticiasListController.getDados();
              },
            ),
          ),
        ],
      ),
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
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('noticias')
                .where('pasta', isNotEqualTo: null)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        title: Column(
                          children: [
                            Visibility(
                              visible: data['urlImagemPrincipal'] != null,
                              child: Image.network(
                                data['urlImagemPrincipal'] ?? '',
                                width: 200,
                                height: 200,
                              ),
                            ),
                            Text(
                              data['titulo'] ?? '--',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        subtitle: Text(data['subtitulo'] ?? '--'),
                        onTap: () async => {
                          await configController
                              .setCurrentId(document.id.toString())
                              .then((value) async => {
                                    await noticiasViewController
                                        .fetchDocument(),
                                    Get.to(const NoticiasView())
                                  }),
                        },
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
