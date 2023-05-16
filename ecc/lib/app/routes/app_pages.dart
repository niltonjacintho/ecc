import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/noticias/noticias_edit/bindings/noticias_noticias_edit_binding.dart';
import '../modules/noticias/noticias_edit/views/noticias_noticias_edit_view.dart';
import '../modules/noticias/noticias_list/bindings/noticias_noticias_list_binding.dart';
import '../modules/noticias/noticias_list/views/noticias_noticias_list_view.dart';
import '../modules/noticias/view/bindings/noticias_view_binding.dart';
import '../modules/noticias/view/views/noticias_view_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const LOGIN = Routes.LOGIN;
  static const NOTICIAS_VIEW = Routes.NOTICIAS_VIEW;

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
      page: () => const NoticiasListView(),
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
  ];
}
