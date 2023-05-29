import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/grupos_controller.dart';

class GruposView extends GetView<GruposController> {
  const GruposView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GruposView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GruposView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
