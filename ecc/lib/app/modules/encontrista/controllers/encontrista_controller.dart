import 'package:ecc/app/modules/encontrista/model/encontrista_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EncontristaController extends GetxController {
  final formKey = GlobalKey<FormState>();

  EncontristaModel encontristaModel = Get.put(EncontristaModel());

  final listaPaginas = [
    {'nome': 'Esposa', 'descricao': 'Dados do Casal'},
    {'nome': 'Marido', 'descricao': 'Dados do Casal'},
    {'nome': 'Casamento', 'descricao': 'Dados do Casal'},
    {'nome': 'Filhos', 'descricao': 'Dados do Casal'},
    {'nome': 'Encontros \nEm Desenvolvimento', 'descricao': 'Dados do Casal'},
    {'nome': 'Endereços', 'descricao': 'Dados do Casal'}
  ];
}
