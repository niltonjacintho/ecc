import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/noticias/model/noticias_model.dart';
import 'package:get/get.dart';

class NoticiasViewController extends GetxController {
  var noticia = NoticiasModel().obs;
  ConfigController configController = Get.put(ConfigController());

  Future<String> fetchDocument() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await configController.getDocumentById(
            'noticias', configController.noticiaCurrentId.value);
    noticia.value = NoticiasModel();
    if (snapshot.exists) {
      final Map<String, dynamic>? data = snapshot.data();
      noticia.value.autor = data?["autor"];
      noticia.value.data = data?['data'];
      noticia.value.noticia = data?['noticia'];
      noticia.value.publicarAte = data?['publicarAte'];
      noticia.value.publicarDe = data?['publicarDe'];
      noticia.value.subtitulo = data?['subtitulo'];
      noticia.value.titulo = data?['titulo'];
      noticia.value.subtitulo = data?['subtitulo'];
      noticia.value.urlImagemPrincipal = data?['urlImagemPrincipal'];
    } else {
      // Document with the specified ID does not exist
    }
    return Future.value('');
  }
}
