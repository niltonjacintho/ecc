import 'dart:io';

import 'package:ecc/app/modules/noticias/model/noticias_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

enum TiposTitulo { edicao, inclusao }

class NoticiasEditController extends GetxController {
  var noticiasModel = NoticiasModel().obs;

  String titulo({TiposTitulo param = TiposTitulo.inclusao}) {
    return (param == TiposTitulo.inclusao
        ? 'Inclusão de Noticias'
        : 'Edição de notíocias');
  }

  late File selectedImage = File('');

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      selectedImage = File(pickedImage.path);
    }
  }
}
