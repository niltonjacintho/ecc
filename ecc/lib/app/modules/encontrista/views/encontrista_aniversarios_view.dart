import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecc/app/modules/encontrista/controllers/encontrista_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EncontristaAniversariosPage extends GetView<EncontristaController> {
  const EncontristaAniversariosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('EncontristaAniversariosPage')),
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('encontrista')
                .where('esposa.mesAniversario', isEqualTo: 1)
                .snapshots(),
            // O stream de dados
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Erro ao carregar os dados.${snapshot.error}');
              } else {
                if (snapshot.hasData) {
//                  return const Text('0000');

                  final listaAniversariantes = snapshot.data?.docs.toList();
                  return ListView.builder(
                    itemCount: listaAniversariantes!.length,
                    itemBuilder: (context, index) {
                      final aniversariante = listaAniversariantes[index];
                      print(controller
                          .tipoNiver[TipoAniversario.Natalicio_esposa]!.nome);
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(DateFormat('dd').format(
                                aniversariante['esposa.nascimento'].toDate())),
                          ),
                          title: Text(
                            aniversariante['esposa.nome'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Text("do ${aniversariante['marido.nome']}"),
                          trailing: Text(DateFormat('EEEEE').format(
                              aniversariante['esposa.nascimento'].toDate())),
                        ),
                      );
                    },
                  );
                } else {
                  return const Text('stil');
                }
              }
            },
          ),
          //   ),
        ));
  }
}
