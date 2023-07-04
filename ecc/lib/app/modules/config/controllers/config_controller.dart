import 'dart:io';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecc/app/modules/noticias/noticias_edit/views/noticias_noticias_edit_view.dart';
import 'package:ecc/app/modules/noticias/noticias_list/controllers/noticias_noticias_list_controller.dart';
import 'package:ecc/app/modules/usuarios/model/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

enum TipoPhoto { galeria, camera }

enum TipoArquivoPhoto { Marido, Esposa, Casal }

class ConfigController extends GetxController {
  final RxDouble _fontSize = 30.0.obs;

  UsuariosModel? usuariosModel;

  double get fontSize => _fontSize.value;

  MaskTextInputFormatter get phoneMaskFormatter => MaskTextInputFormatter(
      mask: '(##) #-####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  MaskTextInputFormatter get dateMaskFormatter => MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  MaskTextInputFormatter get cepMaskFormatter => MaskTextInputFormatter(
      mask: '#####-###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  set fontSize(double value) => {
        _fontSize.value = value,
        _fontSize.value < 10 ? _fontSize.value = 10 : null,
        _fontSize.value > 60 ? _fontSize.value = 60 : null,
      };
  final Map<int, String> monthsInYear = {
    1: "Janeiro",
    2: "Fevereiro",
    3: "Março",
    4: "Abril",
    5: "Maio",
    6: "Junho",
    7: "Julho",
    8: "Agosto",
    9: "Setembro",
    10: "Outubro",
    11: "Novembro",
    12: "Dezembro"
  };

  RxString noticiaCurrentId = '4444'.obs;

  AssetImage appBarBackGroundImage =
      const AssetImage('assets/images/fundoGeral.jpg');

  NoticiasListController noticiasListController =
      Get.put(NoticiasListController());

  Future<String> setCurrentId(String id) {
    noticiaCurrentId.value = id;

    return Future.value(id);
  }

  final TextStyle estiloTitulo = const TextStyle(
      fontSize: 94, fontWeight: FontWeight.w900, color: Colors.black26);

  AppBar padraoBar({String titulo = '', bool allowEdit = true}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: const Color.fromARGB(255, 1, 14, 26),
      elevation: 0,
      title: Text(
        titulo,
        style: const TextStyle(
            color: Color.fromARGB(255, 1, 14, 26), fontSize: 26),
      ),
      centerTitle: false,
      actions: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.blue,
            ),
            onPressed: () {
              if (allowEdit) {
                Get.to(NoticiasEditView());
                noticiasListController.getDados();
              }
            },
          ),
        ),
      ],
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocumentById(
      String collection, String documentId) async {
    final DocumentReference<Map<String, dynamic>> documentRef =
        FirebaseFirestore.instance.collection(collection).doc(documentId);
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await documentRef.get();
    return snapshot;
  }

  final Rx<File?> _selectedImage = Rx<File?>(null);

  Future<File>? _pickPhoto(TipoPhoto modo) async {
    final picker = ImagePicker();
    final XFile? pickedImage;
    if (modo == TipoPhoto.camera) {
      pickedImage = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedImage = await picker.pickImage(source: ImageSource.gallery);
    }
    if (pickedImage != null) {
      return File(pickedImage.path);
    } else {
      return Future.value(File(''));
    }
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _selectedImage.value = File(pickedImage.path);
    }
  }

  void showDialog(BuildContext context,
      {String texto = '',
      String titulo = 'Atenção',
      ArtSweetAlertType tipo = ArtSweetAlertType.info}) {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(type: tipo, title: titulo, text: texto),
    );
  }

  Future<String> uploadImageToFirebaseStorage(File? image,
      {String fileName = ''}) async {
    fileName = fileName == ''
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : fileName;
    String retorno = '';
    try {
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('images')
          .child(fileName);

      final firebase_storage.UploadTask uploadTask = ref.putFile(image!);
      final firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;

      await taskSnapshot.ref.getDownloadURL().then((value) => {
            retorno = value,
          });
      return retorno;
    } catch (e) {
      retorno = e.toString();
      return '';
    }
  }
}
