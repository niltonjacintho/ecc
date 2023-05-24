import 'package:ecc/app/modules/encontrista/model/encontrista_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EsposaForm extends Container {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final controller = Get.put(EncontristaModel(
      encontrista: Encontrista(
          marido: Marido(
              nome: '',
              photo: '',
              nascimento: DateTime(2000),
              telefone: '',
              email: ''),
          esposa: Esposa(
              nome: '',
              photo: '',
              nascimento: DateTime(2000),
              telefone: '',
              email: ''),
          endereco: Endereco(
              logradouro: '',
              bairro: '',
              cidade: '',
              estado: '',
              cep: 0,
              complemento: ''),
          casamento: Casamento(data: DateTime(2000), igreja: ''),
          filhos: [
        Filhos(nome: '', dataNascimento: DateTime(2000), sexo: '')
      ],
          encontro: [
        Encontro(equipe: '', ano: 2000, coordenador: '', observacao: '')
      ])));

  EsposaForm({super.key});
}
