import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class NoticiasNoticiasListController extends GetxController {
  getDados() {
    FirebaseFirestore.instance
        .collection('ecc') // Substitua pelo nome da sua coleção
        .snapshots() // Obtenha um stream de snapshots
        .listen((QuerySnapshot snapshot) {
      // Itere sobre os documentos no snapshot
      for (var document in snapshot.docs) {
        // Acesse os dados do documento
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        // Faça algo com os dados
        String nome = data['descricao'];
        String idade = data['titulo'];

        print('Nome: $nome, Idade: $idade');
      }
    });
  }
}
