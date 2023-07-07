import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecc/app/modules/usuarios/controllers/usuarios_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
      appBar: AppBar(
        title: const Text('Somos E.C.C.'),
      ),
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
                      top: 8, left: 8, right: 8, bottom: 10),
                  child: ListTile(
                    onTap: () {
                      // encontristaController.getListaAniversariantes(
                      //     01, TipoAniversario.Natalicio);
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.pink,
                      child: Text(
                        document['esposa']['nome'].toString().substring(0, 1),
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Text(
                        document['esposa']['nome'].toString().toUpperCase()),
                    subtitle:
                        Text(document['marido']['nome'].toString().trim()),
                  ),
                );
              },
            ).toList(),
          );
        },
      ),

      //  ],
    ));
  }
}
