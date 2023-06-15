import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/encontrista/model/encontrista_model.dart';
import 'package:ecc/app/modules/usuarios/controllers/usuarios_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EncontristaController extends GetxController {
  EncontristaModel? encontristaModel;
  ConfigController configController = Get.put(ConfigController());
  UsuariosController usuariosController = Get.put(UsuariosController());
  Rx<bool> isInitialized = false.obs;
  Rx<GlobalKey<FormState>> formKeyEsposo = GlobalKey<FormState>().obs;
  RxList<EncontristaModel> lista = <EncontristaModel>[].obs;

  final listaPaginas = [
    {'nome': 'Esposa', 'descricao': 'Dados do Casal'},
    {'nome': 'Marido', 'descricao': 'Dados do Casal'},
    {'nome': 'Casamento', 'descricao': 'Dados do Casal'},
    {'nome': 'Filhos', 'descricao': 'Dados do Casal'},
    {'nome': 'Encontros \nEm Desenvolvimento', 'descricao': 'Dados do Casal'},
    {'nome': 'Endereços', 'descricao': 'Dados do Casal'}
  ];

  Future<QuerySnapshot<Map<String, dynamic>>> getLista() {
    return FirebaseFirestore.instance.collection('encontrista').get();
  }

  Future<bool> get(String id) async {
    print('%%%%%%%%%%%%%%%%%%%%%%%  GET ');
    try {
      await Firebase.initializeApp();
      final CollectionReference encontristaCollection =
          FirebaseFirestore.instance.collection('encontrista');
      await encontristaCollection
          .doc(id
              .trim()
              .toLowerCase()) //configController.usuariosModel!.nome.trim())
          .get()
          .then((value) => {
                encontristaModel!
                    .fromJson(value.data() as Map<String, dynamic>),
                print('1111 ${encontristaModel!.esposa.nome}')
              });

      return true;
    } catch (e) {
      return false;
    }
  }

  File createImageFile(TipoArquivoPhoto tipo) {
    File f = File('');
    try {
      switch (tipo) {
        case TipoArquivoPhoto.Marido:
          if (encontristaModel!.marido.photo.trim() != '') {
            f = File(encontristaModel!.marido.photo.trim());
          }
          break;
        case TipoArquivoPhoto.Esposa:
          if (encontristaModel!.esposa.photo.trim() != '') {
            f = File(encontristaModel!.esposa.photo.trim());
          }
          break;
        default:
      }
    } catch (e) {}
    return f;
  }

  Future<bool> gravar() async {
    try {
      await Firebase.initializeApp();
      final CollectionReference encontristaCollection =
          FirebaseFirestore.instance.collection('encontrista');
      await encontristaCollection
          .doc(usuariosController.usuarioAtivo!.value
              .nome) //configController.usuariosModel!.nome.trim())
          .set(encontristaModel!.toJson());
      print('gravou  -  ${encontristaModel!.toJson()}');
      //
      //
      return true;
    } catch (e) {
      print(' ========================= mensagem de erro  ${e.toString()} ');
      print(' ENTROU NO ERRO  ${encontristaModel!.toJson()} ');
      e.printError();
      e.printInfo();
      return false;
    }
  }

  @override
  Future<void> onInit() async {
    print(
        '============================== INICIALIZANDO ==============================');
    formKeyEsposo = GlobalKey<FormState>().obs;
    encontristaModel = Get.put(EncontristaModel(
        marido: Marido(
            nome: ' ',
            photo: 'photo',
            nascimento: DateTime(1900),
            telefone: ' ',
            email: ' '),
        esposa: Esposa(
            nome: '',
            photo: '',
            nascimento: DateTime(1900),
            telefone: '',
            email: ''),
        casamento: Casamento(data: DateTime(1900), igreja: ''),
        endereco: Endereco(
            logradouro: '',
            bairro: '',
            cidade: '',
            estado: '',
            cep: 0,
            complemento: ''),
        filhos: [
          Filhos(nome: '', dataNascimento: DateTime(1900), sexo: ''),
          Filhos(nome: '', dataNascimento: DateTime(1900), sexo: ''),
          Filhos(nome: '', dataNascimento: DateTime(1900), sexo: ''),
          Filhos(nome: '', dataNascimento: DateTime(1900), sexo: ''),
        ],
        encontro: [
          Encontro(equipe: '', ano: 0, coordenador: false, observacao: '')
        ]));
    await get(usuariosController.usuarioAtivo!.value.nome.trim()).then((value) {
      isInitialized.value = true;
    });
    super.onInit();
  }
}
