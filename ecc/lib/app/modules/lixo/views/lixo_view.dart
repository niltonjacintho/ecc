import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lixo_controller.dart';

class LixoView extends GetView<LixoController> {
  const LixoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LixoView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LixoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
