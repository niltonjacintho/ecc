import 'package:flutter/material.dart';
import 'package:flutter_boom_menu_new/flutter_boom_menu_new.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  static bool scrollVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildBoomMenu(),
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  BoomMenu buildBoomMenu() {
    return BoomMenu(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(size: 22.0),
        //child: Icon(Icons.add),
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        scrollVisible: scrollVisible,
        overlayColor: Colors.black,
        elevation: 10,
        overlayOpacity: 0.7,
        children: [
          MenuItemModel(
//          child: Icon(Icons.accessibility, color: Colors.black, size: 40,),
            child: Image.asset('assets/images/logout_icon.png',
                color: Colors.grey[850]),
            title: "Logout",
            titleColor: Colors.grey[850]!,
            subtitle: "Lorem ipsum dolor sit amet, consectetur",
            subTitleColor: Colors.grey[850]!,
            backgroundColor: Colors.grey[50]!,
            onTap: () => print('THIRD CHILD'),
            elevation: 10,
          ),
          MenuItemModel(
            child: Image.asset('assets/images/schemes_icon.png',
                color: Colors.white),
            title: "List",
            titleColor: Colors.white,
            subtitle: "Lorem ipsum dolor sit amet, consectetur",
            subTitleColor: Colors.white,
            backgroundColor: Colors.pinkAccent,
            onTap: () => print('FOURTH CHILD'),
            elevation: 10,
          ),
          MenuItemModel(
            child: Image.asset('assets/images/customers_icon.png',
                color: Colors.grey[850]),
            title: "Team",
            titleColor: Colors.grey[850]!,
            subtitle: "Lorem ipsum dolor sit amet, consectetur",
            subTitleColor: Colors.grey[850]!,
            backgroundColor: Colors.grey[50]!,
            onTap: () => print('THIRD CHILD'),
            elevation: 10,
          ),
          MenuItemModel(
            child: Image.asset('assets/images/profile_icon.png',
                color: Colors.white),
            title: "Profile",
            titleColor: Colors.white,
            subtitle: "Lorem ipsum dolor sit amet, consectetur",
            subTitleColor: Colors.white,
            backgroundColor: Colors.blue,
            onTap: () => print('FOURTH CHILD'),
            elevation: 10,
          )
        ]);
  }
}
