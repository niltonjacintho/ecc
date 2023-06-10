import 'package:ecc/app/modules/paroquias/model/paroquias_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../controllers/paroquias_controller.dart';

class ParoquiasView extends GetView<ParoquiasController> {
  const ParoquiasView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // int index = 0;
    ParoquiasController paroquiasController = Get.put(ParoquiasController());
    //paroquiasController.restoreParoquiaListFromFirestore();
    return SafeArea(
      child: Scaffold(
        body: Builder(builder: (BuildContext context) {
          return Obx(
            () => !paroquiasController.isInitialized.value
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.blue))
                : IndexedStack(
                    index: paroquiasController.index.value,
                    children: [
                      SearchableList<ParoquiasModel>(
                        initialList: paroquiasController.lista,
                        builder: (ParoquiasModel paroquia) =>
                            ParoquiaItem(paroquia: paroquia),
                        filter: (value) => paroquiasController.lista
                            .where(
                              (element) =>
                                  element.shortName!
                                      .toLowerCase()
                                      .trim()
                                      .contains(value.toLowerCase()) ||
                                  element.bairro!
                                      .toLowerCase()
                                      .trim()
                                      .contains(value.toLowerCase()),
                            )
                            .toList(),
                        // asyncListCallback: () async {
                        //   await Future.delayed(
                        //     const Duration(
                        //       milliseconds: 100,
                        //     ),
                        //   );
                        //   return paroquiasController.lista;
                        // },
                        asyncListFilter: (q, list) {
                          return list
                              .where((element) => element.nome.contains(q))
                              .toList();
                        },
                        emptyWidget: const EmptyView(),
                        inputDecoration: InputDecoration(
                          labelText: "Procurar paróquia",
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      Container(
                        color: const Color.fromARGB(255, 236, 202, 200),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () => paroquiasController.setIndex(),
                              child: HtmlWidget(
                                paroquiasController.paroquiasAtiva.detalhes,
                                textStyle: const TextStyle(fontSize: 20),
                                customStylesBuilder: (element) {
                                  if (element.classes.contains('foo')) {
                                    return {'color': 'red'};
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        }),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Não encontrei paróquias para esta pesquisa',
        style: TextStyle(fontSize: 22),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ParoquiaItem extends StatelessWidget {
  final ParoquiasModel paroquia;

  const ParoquiaItem({
    Key? key,
    required this.paroquia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ParoquiasController paroquiasController = Get.put(ParoquiasController());
    paroquiasController.paroquiasAtiva = paroquia;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  paroquiasController.paroquiasAtiva = paroquia;
                  paroquiasController.setIndex();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      paroquia.shortName!,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      softWrap: false,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      paroquia.paroco!,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
