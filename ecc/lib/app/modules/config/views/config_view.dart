import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/config_controller.dart';

class ConfigView extends GetView<ConfigController> {
  const ConfigView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ConfigView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ConfigView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
