import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/encontrista/model/encontrista_model.dart';
import 'package:get/get.dart';

class EncontristaController extends GetxController {
  EncontristaModel? encontristaModel;
  ConfigController configController = Get.put(ConfigController());

  final listaPaginas = [
    {'nome': 'Esposa', 'descricao': 'Dados do Casal'},
    {'nome': 'Marido', 'descricao': 'Dados do Casal'},
    {'nome': 'Casamento', 'descricao': 'Dados do Casal'},
    {'nome': 'Filhos', 'descricao': 'Dados do Casal'},
    {'nome': 'Encontros \nEm Desenvolvimento', 'descricao': 'Dados do Casal'},
    {'nome': 'Endereços', 'descricao': 'Dados do Casal'}
  ];

  final CollectionReference _encontristaCollection =
      FirebaseFirestore.instance.collection('encontrista');

  Future<bool> gravar() async {
    try {
      await _encontristaCollection
          .doc(configController.usuariosModel!.nome)
          .set(encontristaModel!.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void onInit() {
    encontristaModel = Get.put(EncontristaModel(
        marido: Marido(
            nome: '',
            photo: '',
            nascimento: DateTime(1900),
            telefone: '',
            email: ''),
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
    super.onInit();
  }
}
