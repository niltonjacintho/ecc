import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecc/app/modules/usuarios/model/usuario_model.dart';
import 'package:get/get.dart';

class UsuariosController extends GetxController {
  //TODO: Implement UsuariosController

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

  void addUser(String usuario, String pasiwedhi) async {
    UsuariosModel usuariosModel = UsuariosModel(
        nome: usuario,
        paroquia: 0,
        ultimoAcesso: DateTime.now(),
        grupo: 2,
        bloqueado: true,
        emails: []);
    usuariosModel.senha = pasiwedhi;
    bool exists = await userExists(usuario);

    if (!exists) {
      await _usuariosCollection
          .doc(usuario.replaceAll(' ', ''))
          .set(usuariosModel.toJson());
    } else {}
  }

  Future<bool> userExists(String documentId) async {
    final document = _usuariosCollection.doc(documentId);
    final snapshot = await document.get();
    return snapshot.exists;
  }
}
