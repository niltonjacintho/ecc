import 'package:ecc/app/modules/encontrista/views/encontrista_view.dart';
import 'package:ecc/app/modules/home/controllers/navbar_class.dart';
import 'package:ecc/app/modules/login/views/login_view.dart';
import 'package:ecc/app/modules/noticias/noticias_list/views/noticias_noticias_list_view.dart';
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
      drawer: const NavBar(),
      floatingActionButton: buildBoomMenu(),
      body: SizedBox.expand(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/fundoGeral.jpg'),
              fit: BoxFit.cover,
            ),
          ),
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
            title: "Sair",
            titleColor: Colors.grey[850]!,
            subtitle: "Encerrar esta sessão",
            subTitleColor: Colors.grey[850]!,
            backgroundColor: Colors.grey[50]!,
            onTap: () => Get.off(LoginPage()),
            elevation: 10,
          ),
          MenuItemModel(
            child: Image.asset('assets/images/schemes_icon.png',
                color: Colors.white),
            title: "Notícias..",
            titleColor: Colors.white,
            subtitle: "Notícias do nosso ECC",
            subTitleColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 36, 1, 13),
            onTap: () => Get.to(NoticiasListView()),
            elevation: 10,
          ),
          MenuItemModel(
            child: Image.asset('assets/images/customers_icon.png',
                color: Colors.grey[850]),
            title: "Atualize seus dados",
            titleColor: Colors.grey[850]!,
            subtitle: "Permite atualizar todos os seus dados",
            subTitleColor: Colors.grey[850]!,
            backgroundColor: Colors.grey[50]!,
            onTap: () => Get.to(const EncontristaView()),
            elevation: 10,
          ),
          MenuItemModel(
            child: Image.asset('assets/images/profile_icon.png',
                color: Colors.white),
            title: "Aniversáriantes do mês",
            titleColor: Colors.white,
            subtitle: "Lista dos nossos aniversariantes de casamento tb",
            subTitleColor: Colors.white,
            backgroundColor: Colors.blue,
            onTap: () => print('FOURTH CHILD'),
            elevation: 10,
          ),
          MenuItemModel(
            child: Image.asset('assets/images/profile_icon.png',
                color: const Color.fromARGB(255, 248, 248, 248)),
            title: "Nossos Encontros",
            titleColor: Colors.white,
            subtitle: "Como foram nossos encontros",
            subTitleColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 2, 35, 61),
            onTap: () => print('FOURTH CHILD'),
            elevation: 10,
          ),
          MenuItemModel(
            child: Image.asset('assets/images/profile_icon.png',
                color: const Color.fromARGB(255, 248, 248, 248)),
            title: "Gestão de notícias",
            titleColor: Colors.white,
            subtitle: "Manutenção das notícias",
            subTitleColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 8, 52, 32),
            onTap: () => print('FOURTH CHILD'),
            elevation: 10,
          )
        ]);
  }
}
