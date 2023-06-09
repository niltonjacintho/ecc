import 'package:ecc/app/modules/paroquias/model/paroquias_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../controllers/paroquias_controller.dart';

class ParoquiasView extends GetView<ParoquiasController> {
  const ParoquiasView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ParoquiasController paroquiasController = Get.put(ParoquiasController());
    //paroquiasController.restoreParoquiaListFromFirestore();
    return Scaffold(
      appBar: AppBar(
        title: const Text('ParoquiasView'),
        centerTitle: true,
      ),
      body: Builder(builder: (BuildContext context) {
        return Obx(
          () => !paroquiasController.isInitialized.value
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.blue))
              : SearchableList<ParoquiasModel>(
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
                  asyncListCallback: () async {
                    await Future.delayed(
                      const Duration(
                        milliseconds: 100,
                      ),
                    );
                    return paroquiasController.lista;
                  },
                  asyncListFilter: (q, list) {
                    return list
                        .where((element) => element.nome.contains(q))
                        .toList();
                  },
                  emptyWidget: const EmptyView(),
                  inputDecoration: InputDecoration(
                    labelText: "Search Actor",
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
        );
      }),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text('no actor is found with this name'),
      ],
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
                    paroquia.bairro!,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
