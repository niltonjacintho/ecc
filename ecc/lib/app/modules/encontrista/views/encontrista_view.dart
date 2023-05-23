import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/encontrista_controller.dart';

class EncontristaView extends GetView<EncontristaController> {
  const EncontristaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EncontristaView'),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 5,
        child: Column(
          children: <Widget>[
            ButtonsTabBar(
              backgroundColor: Colors.red,
              unselectedBackgroundColor: Colors.grey[300],
              unselectedLabelStyle: const TextStyle(color: Colors.black),
              labelStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              tabs: const [
                Tab(
                  icon: Icon(Icons.directions_car),
                  text: "Casal",
                ),
                Tab(
                  icon: Icon(Icons.directions_transit),
                  text: "Casamento",
                ),
                Tab(
                  icon: Icon(Icons.directions_bike),
                  text: 'Filhos',
                ),
                Tab(icon: Icon(Icons.directions_car), text: 'endereço'),
                Tab(
                  icon: Icon(Icons.directions_transit),
                  text: 'Encontros',
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: <Widget>[
                  Center(
                    child: Icon(Icons.directions_car),
                  ),
                  Center(
                    child: Icon(Icons.directions_transit),
                  ),
                  Center(
                    child: Icon(Icons.directions_bike),
                  ),
                  Center(
                    child: Icon(Icons.directions_car),
                  ),
                  Center(
                    child: Icon(Icons.directions_transit),
                  ),
                  // Center(
                  //   child: Icon(Icons.directions_bike),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
