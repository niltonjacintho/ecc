import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/usuarios/model/usuario_model.dart';
import 'package:encryptor/encryptor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuariosController extends GetxController {
  final ConfigController configController = Get.put(ConfigController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //   forceCodeForRefreshToken: true,
  //   scopes: <String>[PhotosLibraryApi.photoslibraryReadonlyScope],
  // );
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  BuildContext? context;

  Rx<UsuariosModel>? usuarioAtivo;

  final CollectionReference _usuariosCollection =
      FirebaseFirestore.instance.collection('usuarios');

  Future<void> cadastrarUsuario(Map<String, dynamic> usuario) async {
    await _usuariosCollection.add(usuario);
  }

  Future<void> atualizarUsuario(
      String usuarioId, Map<String, dynamic> usuarioAtualizado) async {
    await _usuariosCollection.doc(usuarioId).update(usuarioAtualizado);
  }

  Future<void> deletarUsuario(String usuarioId) async {
    await _usuariosCollection.doc(usuarioId).delete();
  }

  Future<bool> addUser(
      BuildContext context, String usuario, String pasiwedhi) async {
    if ((pasiwedhi.length < 4) | (usuario.length < 4)) {
      configController.showDialog(context,
          texto:
              'Usuario ou senha muito pequenos. Ambos precisam ter mais de 4 caracteres no mínimo!',
          tipo: ArtSweetAlertType.danger);
      return false;
    } else {
      usuario = usuario.replaceAll(" ", "");
      var encrypted = Encryptor.encrypt(pasiwedhi, pasiwedhi);
      UsuariosModel usuariosModel = UsuariosModel(
          nome: usuario,
          paroquia: 0,
          ultimoAcesso: DateTime.now(),
          grupo: 2,
          bloqueado: true,
          emails: []);
      usuariosModel.senha = encrypted;

      bool exists = await userExists(usuario);

      if (!exists) {
        await _usuariosCollection.doc(usuario).set(usuariosModel.toJson());
        return true;
      } else {
        // ignore: use_build_context_synchronously
        // configController.showDialog(context,
        //     texto: 'Já existe um usuário com este nome!!',
        //     tipo: ArtSweetAlertType.danger);
        return false;
      }
    }
  }

  bool containsEmail(List<Emails> list, Emails email) {
    return list.any((element) => element.email == email.email);
  }

  Future<bool> userExists(String documentId) async {
    final document = _usuariosCollection.doc(documentId);
    final snapshot = await document.get();
    return snapshot.exists;
  }

  Future<bool> login(String user, String pass) async {
    user = user.replaceAll(" ", "");
    final SharedPreferences pref = await _prefs;
    var existe = await userExists(user);
    if (existe) {
      final document = _usuariosCollection.doc(user);
      final snapshot = await document.get();
      String decri = '';
      try {
        decri = Encryptor.decrypt(pass, snapshot['senha']);
      } catch (e) {
        decri = '';
      }
      if (decri == '') {
        return false;
      } else {
        UserCredential? userCredential = await _signInWithGoogle();

        List<Emails> emails = [];
        try {
          snapshot['emails']
              .forEach((value) => emails.add(Emails(email: value['email'])));
        } catch (e) {}
        if (!containsEmail(
            emails, Emails(email: userCredential!.user!.email!))) {
          emails.add(Emails(email: userCredential.user!.email.toString()));
        }
        UsuariosModel usuariosModel = UsuariosModel(
            nome: snapshot['nome'],
            paroquia: 0,
            ultimoAcesso: DateTime.now(),
            grupo: 2,
            bloqueado: snapshot['bloqueado'],
            emails: emails);
        usuarioAtivo!.value = usuariosModel;
        pref.setString("usuario", usuariosModel.nome);
        configController.usuariosModel = usuariosModel;
        usuariosModel.senha = snapshot['senha'];
        await _usuariosCollection
            .doc(usuariosModel.nome.replaceAll(' ', ''))
            .set(usuariosModel.toJson());
      }
    }
    return existe;
  }

  Future<UserCredential?> _signInWithGoogle() async {
    final SharedPreferences prefs = await _prefs;
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      prefs.setString('token', googleAuth.idToken!);
      return userCredential;
    } catch (e) {
      configController.showDialog(context!,
          texto: 'Ops. Houve um problema na conexão! Tente daqui a pouco!',
          tipo: ArtSweetAlertType.danger);
      return null;
    }
    return null;
  }

  @override
  Future<bool> refresh() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String usuario = pref.getString("usuario")!;
    configController.usuariosModel = usuarioAtivo!.value;
    final document = _usuariosCollection.doc(usuario);
    final snapshot = await document.get();
    UserCredential? userCredential = await _signInWithGoogle();
    List<Emails> emails = [];
    try {
      snapshot['emails']
          .forEach((value) => emails.add(Emails(email: value['email'])));
    } catch (e) {}
    if (!containsEmail(emails, Emails(email: userCredential!.user!.email!))) {
      emails.add(Emails(email: userCredential.user!.email.toString()));
    }
    UsuariosModel usuariosModel = UsuariosModel(
        nome: snapshot['nome'],
        paroquia: 0,
        ultimoAcesso: DateTime.now(),
        grupo: 2,
        bloqueado: snapshot['bloqueado'],
        emails: emails);
    usuarioAtivo!.value = usuariosModel;
    configController.usuariosModel = usuariosModel;
    return Future.value(true);
  }

  @override
  void onInit() {
    usuarioAtivo = usuarioAtivo = Get.put(UsuariosModel(
        nome: ' ',
        paroquia: 0,
        ultimoAcesso: DateTime(1900),
        grupo: 2,
        bloqueado: true,
        emails: [])).obs;
    super.onInit();
  }
}
