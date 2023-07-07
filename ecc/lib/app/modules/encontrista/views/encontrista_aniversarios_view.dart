import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecc/app/modules/encontrista/controllers/encontrista_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class EncontristaAniversariosPage extends GetView<EncontristaController> {
  const EncontristaAniversariosPage({super.key});

  static GroupButtonController groupcontroller = GroupButtonController(
    selectedIndex: DateTime.now().month - 1,
    onDisablePressed: (i) => print('Button #$i is disabled'),
  );
  static double buttonWidth = 120;
  static double buttonheigth = 40;
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);
    buttonWidth = MediaQuery.of(context).size.width * 0.10;
    var mes = 0.obs;
    mes.value = DateTime.now().month - 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aniversários',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      bottomSheet: GroupButton<String>(
        options: const GroupButtonOptions(
          groupingType: GroupingType.wrap,
          unselectedTextStyle: TextStyle(fontWeight: FontWeight.normal),
          selectedTextStyle: TextStyle(fontSize: 100),
          elevation: 20,
        ),
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
            child: SizedBox(
              width: buttonWidth,
              height: buttonheigth,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                  child: Text(
                    mes,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: selected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      body: Obx(
        () => StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('aniversarios')
              .where('mes', isEqualTo: mes.value)
              .orderBy('nome')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Erro ao carregar os dados.${snapshot.error}');
            } else {
              final listaAniversariantes = snapshot.data?.docs.toList();
              if ((listaAniversariantes != null) &&
                  (listaAniversariantes.isNotEmpty)) {
                final listaAniversariantes = snapshot.data?.docs.toList();
                return ListView.builder(
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
                          trailing: Text(DateFormat('EEEEE', 'pt-br')
                              .format(aniversariante['data'].toDate())),
                        ),
                      );
                    });
              } else {
                return const Center(
                    child: Text(
                  'Não encontrei aniversariantes neste mês !',
                  style: TextStyle(fontSize: 20),
                ));
              }
            }
          },
        ),
      ),
    );
  }
}
