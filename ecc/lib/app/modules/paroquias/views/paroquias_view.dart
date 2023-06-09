import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/paroquias_controller.dart';

class ParoquiasView extends GetView<ParoquiasController> {
  const ParoquiasView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ParoquiasController paroquiasController = Get.put(ParoquiasController());
    paroquiasController.restoreParoquiaListFromFirestore();
    return Scaffold(
      appBar: AppBar(
        title: const Text('ParoquiasView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ParoquiasView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
