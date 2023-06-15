import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecc/app/modules/usuarios/controllers/usuarios_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:recase/recase.dart';

import '../controllers/encontrista_controller.dart';

class EncontristaListView extends GetView<EncontristaController> {
  const EncontristaListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EncontristaController encontristaController =
        Get.put(EncontristaController());

    UsuariosController usuariosController = Get.put(UsuariosController());

    return SafeArea(
      child: Scaffold(
          body: StreamBuilder<QuerySnapshot>(
        stream: encontristaController.getLista2(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs.map(
              (DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 8, right: 8, bottom: 20),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.pink,
                      child: Text(
                        ReCase(document['esposa']['nome']
                                .toString()
                                .substring(0, 1)
                                .toUpperCase())
                            .camelCase,
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Text(document['esposa']['nome']),
                    subtitle:
                        Text(document['marido']['nome'].toString().trim()),
                  ),
                );
              },
            ).toList(),
          );
        },
      )
          //),

          // Builder(
          //   builder: (BuildContext context) {
          //     return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          //       future: encontristaController.getLista(),
          //       builder: (context, snapshot) {
          //         if (snapshot.connectionState == ConnectionState.waiting) {
          //           return const CircularProgressIndicator(); // Mostra um indicador de progresso enquanto os dados são carregados
          //         }

          //         if (snapshot.hasError) {
          //           return Text('Ocorreu um erro: ${snapshot.error}');
          //         }

          //         // O snapshot contém os dados do Firebase
          //         final documents = snapshot.data!.docs;

          //         return Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: ListView.separated(
          //             separatorBuilder: (context, index) {
          //               return const Divider(
          //                 thickness: 3,
          //               );
          //             },
          //             itemCount: documents.length,
          //             itemBuilder: (context, index) {
          //               // Construa a interface do item da lista com base nos dados do documento
          //               final document = documents[index].data();

          //               return ListTile(
          //                 leading: CircleAvatar(
          //                   backgroundColor: Colors.pink,
          //                   child: Text(
          //                     ReCase(document['esposa']['nome']
          //                             .toString()
          //                             .substring(0, 1)
          //                             .toUpperCase())
          //                         .camelCase,
          //                     style: const TextStyle(fontWeight: FontWeight.w900),
          //                   ),
          //                 ),
          //                 shape: RoundedRectangleBorder(
          //                   side: const BorderSide(width: 2),
          //                   borderRadius: BorderRadius.circular(20),
          //                 ),
          //                 title: Text(document['esposa']['nome']),
          //                 subtitle:
          //                     Text(document['marido']['nome'].toString().trim()),
          //               );
          //             },
          //           ),
          //         );
          //       },
          //     );
          //   },
          // ),
          ),
    );
  }
}
