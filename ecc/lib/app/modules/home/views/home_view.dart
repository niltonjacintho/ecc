import 'package:ecc/app/modules/encontrista/views/encontrista_list_view.dart';
import 'package:ecc/app/modules/encontrista/views/encontrista_view.dart';
import 'package:ecc/app/modules/home/controllers/navbar_class.dart';
import 'package:ecc/app/modules/loginuser/views/loginuser_view.dart';
import 'package:ecc/app/modules/noticias/noticias_list/views/noticias_noticias_list_view.dart';
import 'package:ecc/app/modules/paroquias/views/paroquias_view.dart';
import 'package:ecc/app/modules/usuarios/controllers/usuarios_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boom_menu_new/flutter_boom_menu_new.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:recase/recase.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  static bool scrollVisible = true;
  static const menuOptions = [];
  @override
  Widget build(BuildContext context) {
    UsuariosController usuariosController = Get.put(UsuariosController());
    return Scaffold(
      drawer: const NavBar(),
      floatingActionButton: buildBoomMenu(),
      body: GridView.custom(
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          repeatPattern: QuiltedGridRepeatPattern.inverted,
          pattern: [
            const QuiltedGridTile(1, 2),
            //  const QuiltedGridTile(1, 1),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) {
            switch (index) {
              case 0:
                return Container(
                  color: const Color.fromARGB(255, 65, 117, 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        children: [
                          const Text(
                            'Seja muito bem vindo(a)!',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            ReCase(usuariosController.usuarioAtivo!.value.nome)
                                .pascalCase,
                            style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
                break;
              case 1:
                return Container(
                  color: const Color.fromARGB(255, 53, 53, 186),
                  child: Center(
                      child: GestureDetector(
                          onTap: () => Get.to(const EncontristaListView()),
                          child: const Text('Em desenvolvimento.'))),
                );
                break;
              default:
                return Container(
                  color: Colors.amber,
                  child: const Center(child: Text('Em desenvolvimento.')),
                );
                break;
            }
            return null;
          },
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
            onTap: () => Get.off(LoginuserView()),
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
            title: "Paróquias do Rio de Janeiro",
            titleColor: Colors.white,
            subtitle: "Lista das paroquias do nosso estado!!",
            subTitleColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 8, 52, 32),
            onTap: () => Get.to(const ParoquiasView()),
            elevation: 10,
          )
        ]);
  }
}
