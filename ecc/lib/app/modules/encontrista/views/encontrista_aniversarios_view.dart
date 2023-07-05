import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecc/app/modules/encontrista/controllers/encontrista_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';

class EncontristaAniversariosPage extends GetView<EncontristaController> {
  const EncontristaAniversariosPage({super.key});

  static GroupButtonController groupcontroller = GroupButtonController(
    selectedIndex: DateTime.now().month - 1,
    onDisablePressed: (i) => print('Button #$i is disabled'),
  );

  @override
  Widget build(BuildContext context) {
    var mes = 0.obs;
    mes.value = DateTime.now().month - 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('EncontristaAniversariosPage'),
      ),
      bottomSheet: GroupButton<String>(
        controller: groupcontroller,
        buttons: const [
          'Jan',
          'Fev',
          'Mar',
          'Abr',
          'Mai',
          'Jun',
          'Jul',
          'Ago',
          'Set',
          'Out',
          'Nov',
          'Dez'
        ],
        onSelected: (mesSelected, i, selected) => mes.value = i,
        // debugPrint('Button: $mes index: $i selected: $selected'),
        buttonBuilder: (selected, mes, context) {
          return Card(
            color: selected ? Colors.amber[900] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                mes,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
      body:
          //  Expanded(
          //   child:
          //   Row(
          // // mainAxisAlignment: MainAxisAlignment.end,
          // mainAxisSize: MainAxisSize.max,
          // crossAxisAlignment: CrossAxisAlignment.start,
          // children: [
          //   // Expanded(
          //   //   child:
          //   GroupButton<String>(
          //     controller: groupcontroller,
          //     buttons: const [
          //       'Jan',
          //       'Fev',
          //       'Mar',
          //       'Abr',
          //       'Mai',
          //       'Jun',
          //       'Jul',
          //       'Ago',
          //       'Set',
          //       'Out',
          //       'Nov',
          //       'Dez'
          //     ],
          //     onSelected: (mesSelected, i, selected) => mes.value = i,
          //     // debugPrint('Button: $mes index: $i selected: $selected'),
          //     buttonBuilder: (selected, mes, context) {
          //       return Card(
          //         color: selected ? Colors.amber[900] : Colors.white,
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Text(
          //             mes,
          //             style: TextStyle(
          //               color: selected ? Colors.white : Colors.black,
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //     //    ),
          //   ),
          Obx(
        () => StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('aniversarios')
              .where('mes', isEqualTo: mes.value)
              .snapshots(),
          // O stream de dados
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Erro ao carregar os dados.${snapshot.error}');
            } else {
              if (snapshot.hasData) {
                final listaAniversariantes = snapshot.data?.docs.toList();
                return
//               Column(
//                 verticalDirection: VerticalDirection.up,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.max,
// //                mainAxisAlignment: MainAxisAlignment.,
//                 children: [
//                   Flexible(
//                     //  flex: 1,
//                     child: GroupButton<String>(
//                       controller: groupcontroller,
//                       buttons: const [
//                         'Jan',
//                         'Fev',
//                         'Mar',
//                         'Abr',
//                         'Mai',
//                         'Jun',
//                         'Jul',
//                         'Ago',
//                         'Set',
//                         'Out',
//                         'Nov',
//                         'Dez'
//                       ],
//                       onSelected: (mesSelected, i, selected) => mes.value = i,
//                       // debugPrint('Button: $mes index: $i selected: $selected'),
//                       buttonBuilder: (selected, mes, context) {
//                         return Card(
//                           color: selected ? Colors.amber[900] : Colors.white,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               mes,
//                               style: TextStyle(
//                                 color: selected ? Colors.white : Colors.black,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   Flexible(
//                     //    flex: 10,
//                     child:
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: listaAniversariantes!.length,
                        itemBuilder: (context, index) {
                          final aniversariante = listaAniversariantes[index];
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(aniversariante['dia'].toString()),
                              ),
                              title: Text(
                                aniversariante['nome'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              subtitle: Text(aniversariante['detalhes'] +
                                  "    (" +
                                  aniversariante['tipo'] +
                                  ")"),
                              trailing: Text(DateFormat('EEEEE')
                                  .format(aniversariante['data'].toDate())),
                            ),
                          );
                        });
                //    ),
                //    ),
                //  ],
                // );
              } else {
                return const Text('stil');
              }
            }
          },
        ),
      ),
      //],
      //   ),
    );
  }
}
