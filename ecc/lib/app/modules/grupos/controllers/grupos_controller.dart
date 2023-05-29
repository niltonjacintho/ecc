import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecc/app/modules/grupos/model/grupos_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GruposController extends GetxController {
  void inicializarGrupos(BuildContext context) async {
    try {
      await Firebase.initializeApp();
      final CollectionReference dadosRef =
          FirebaseFirestore.instance.collection('grupos');
      await dadosRef.doc('0').set(GruposModel(
              id: 0, nome: 'Administrador', isadmin: true, iseditor: true)
          .toJson());
      await dadosRef.doc('100').set(
          GruposModel(id: 1, nome: 'Editor', isadmin: false, iseditor: true)
              .toJson());
      await dadosRef.doc('200').set(
          GruposModel(id: 2, nome: 'Normal', isadmin: false, iseditor: false)
              .toJson());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados salvos com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar dados: $e')),
      );
    }
  }
}
