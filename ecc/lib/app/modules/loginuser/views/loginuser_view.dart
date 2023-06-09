import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/home/views/home_view.dart';
import 'package:ecc/app/modules/usuarios/controllers/usuarios_controller.dart';
import 'package:ecc/app/modules/usuarios/views/usuarios_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginuserView extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  UsuariosController usuariosController =
      Get.put(UsuariosController(), permanent: true);

  LoginuserView({super.key});

  Future<bool> login(String user, String pass) async {
    var retorno = await usuariosController.login(user, pass);
    return retorno; // Adicione a lógica para verificar as credenciais aqui
  }

  void forgotPassword() {
    // Adicione a lógica para lidar com a recuperação de senha aqui
  }

  @override
  Widget build(BuildContext context) {
    ConfigController configController = Get.put(ConfigController());
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Usuário',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    usuariosController.context = context;
                    var loginOk = await login(usernameController.value.text,
                        passwordController.value.text);
                    if (loginOk) {
                      Get.offAll(const HomeView());
                      //Get.to(const HomeView());
                    } else {
                      // ignore: use_build_context_synchronously
                      configController.showDialog(context,
                          texto:
                              'Não foi possivel conectar. Verifique seu usuário e senha e se vc esta com acesso a internet!',
                          tipo: ArtSweetAlertType.danger);
                    }
                  },
                  child: const Text('Entrar'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        forgotPassword();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      child: const Text('Esqueci minha senha'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(const UsuariosView());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      child: const Text('Cadastrar-se'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
