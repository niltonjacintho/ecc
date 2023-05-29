import 'package:ecc/app/modules/config/controllers/httpImport_controller.dart';
import 'package:ecc/app/modules/grupos/controllers/grupos_controller.dart';
import 'package:ecc/app/modules/noticias/noticias_edit/views/noticias_noticias_edit_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_popup_dialog_null_safety/slide_popup_dialog.dart'
    as slideDialog;

class NavBar extends StatelessWidget {
  const NavBar({super.key});
  static HttpImportController httpImportController =
      Get.put(HttpImportController());

  @override
  Widget build(BuildContext context) {
    void _showDialog({String texto = '', Color cor = Colors.green}) {
      slideDialog.showSlideDialog(
        context: context,
        child: Text(texto),
        barrierColor: Colors.white.withOpacity(0.7),
        pillColor: Colors.red,
        backgroundColor: cor,
      );
    }

    final GruposController gruposController = Get.put(GruposController());
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('ECC - Admin'),
            accountEmail: const Text('ecc@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/ecc.jpg',
                  fit: BoxFit.cover,
                  width: 190,
                  height: 190,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.newspaper),
            title: const Text('Criar notícias'),
            onTap: () {
              Get.to(NoticiasEditView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.group_add),
            title: const Text('Inicializar Grupos'),
            onTap: () {
              gruposController.inicializarGrupos(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.build),
            title: const Text('Importar Paróquias'),
            onTap: () async {
              await httpImportController
                  .importarListaParoquias()
                  .then((value) => _showDialog(texto: value));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_4),
            title: const Text('Listar usuários'),
            onTap: () {
              _showDialog();
            },
          ),
        ],
      ),
    );
  }
}
