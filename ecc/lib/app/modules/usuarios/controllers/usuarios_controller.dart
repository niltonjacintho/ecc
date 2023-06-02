import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/usuarios/model/usuario_model.dart';
import 'package:encryptor/encryptor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UsuariosController extends GetxController {
  final ConfigController configController = Get.put(ConfigController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final CollectionReference _usuariosCollection =
      FirebaseFirestore.instance.collection('usuarios');

  Future<void> cadastrarUsuario(Map<String, dynamic> usuario) async {
    await _usuariosCollection.add(usuario);
  }

  // Future<List<Map<String, dynamic>>> buscarUsuarios() async {
  //   final querySnapshot = await _usuariosCollection.get();
  //   return querySnapshot.docs.map((doc) => doc.data()).toList();
  // }

  Future<void> atualizarUsuario(
      String usuarioId, Map<String, dynamic> usuarioAtualizado) async {
    await _usuariosCollection.doc(usuarioId).update(usuarioAtualizado);
  }

  Future<void> deletarUsuario(String usuarioId) async {
    await _usuariosCollection.doc(usuarioId).delete();
  }

  Future<bool> addUser(String usuario, String pasiwedhi) async {
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
      await _usuariosCollection
          .doc(usuario.replaceAll(' ', ''))
          .set(usuariosModel.toJson());
      return true;
    } else {
      return false;
    }
  }

  Future<bool> userExists(String documentId) async {
    final document = _usuariosCollection.doc(documentId);
    print(documentId);
    document.printError();
    final snapshot = await document.get();
    return snapshot.exists;
  }

  Future<bool> login(String user, String pass) async {
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
        Map<String, String> map = {};
        try {
          snapshot['emails']
              .forEach((value) => emails.add(Emails(email: value['email'])));
        } catch (e) {}

        emails.add(Emails(email: userCredential!.user!.email.toString()));
        UsuariosModel usuariosModel = UsuariosModel(
            nome: snapshot['nome'],
            paroquia: 0,
            ultimoAcesso: DateTime.now(),
            grupo: 2,
            bloqueado: snapshot['bloqueado'],
            emails: emails);
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
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    return userCredential;
  }
}
