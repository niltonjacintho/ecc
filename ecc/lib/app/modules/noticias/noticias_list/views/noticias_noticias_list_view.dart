import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/noticias_noticias_list_controller.dart';

class NoticiasListView extends GetView<NoticiasNoticiasListController> {
  const NoticiasListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                // do something
              },
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('sua_colecao').snapshots(),
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
              return ListTile(
                title: Text(data['titulo']),
                subtitle: Text(data['subtitulo']),
                trailing: Text(data['data_inicio_publicacao']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
