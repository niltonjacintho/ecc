import 'package:get/get.dart';

import '../modules/config/bindings/config_binding.dart';
import '../modules/config/views/config_view.dart';
import '../modules/encontrista/bindings/encontrista_binding.dart';
import '../modules/encontrista/views/encontrista_view.dart';
import '../modules/grupos/bindings/grupos_binding.dart';
import '../modules/grupos/views/grupos_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/lixo/bindings/lixo_binding.dart';
import '../modules/lixo/views/lixo_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/loginuser/bindings/loginuser_binding.dart';
import '../modules/loginuser/views/loginuser_view.dart';
import '../modules/noticias/noticias_edit/bindings/noticias_noticias_edit_binding.dart';
import '../modules/noticias/noticias_edit/views/noticias_noticias_edit_view.dart';
import '../modules/noticias/noticias_list/bindings/noticias_noticias_list_binding.dart';
import '../modules/noticias/noticias_list/views/noticias_noticias_list_view.dart';
import '../modules/noticias/view/bindings/noticias_view_binding.dart';
import '../modules/noticias/view/views/noticias_view_view.dart';
import '../modules/paroquias/bindings/paroquias_binding.dart';
import '../modules/paroquias/views/paroquias_view.dart';
import '../modules/usuarios/bindings/usuarios_binding.dart';
import '../modules/usuarios/views/usuarios_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const LOGIN = Routes.LOGIN;
  static const NOTICIAS_VIEW = Routes.NOTICIAS_VIEW;
  static const LOGINUSER = Routes.LOGINUSER;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NOTICIAS_NOTICIAS_LIST,
      page: () => NoticiasListView(),
      binding: NoticiasListBinding(),
    ),
    GetPage(
      name: _Paths.NOTICIAS_NOTICIAS_EDIT,
      page: () => NoticiasEditView(),
      binding: NoticiasEditBinding(),
    ),
    GetPage(
      name: _Paths.NOTICIAS_VIEW,
      page: () => const NoticiasView(),
      binding: NoticiasViewBinding(),
    ),
    GetPage(
      name: _Paths.CONFIG,
      page: () => const ConfigView(),
      binding: ConfigBinding(),
    ),
    GetPage(
      name: _Paths.ENCONTRISTA,
      page: () => const EncontristaView(),
      binding: EncontristaBinding(),
    ),
    GetPage(
      name: _Paths.GRUPOS,
      page: () => const GruposView(),
      binding: GruposBinding(),
    ),
    GetPage(
      name: _Paths.USUARIOS,
      page: () => const UsuariosView(),
      binding: UsuariosBinding(),
    ),
    GetPage(
      name: _Paths.LOGINUSER,
      page: () => LoginuserView(),
      binding: LoginuserBinding(),
    ),
    GetPage(
      name: _Paths.LIXO,
      page: () => const LixoView(),
      binding: LixoBinding(),
    ),
    GetPage(
      name: _Paths.PAROQUIAS,
      page: () => const ParoquiasView(),
      binding: ParoquiasBinding(),
    ),
  ];
}
