import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/encontrista/model/encontristaAniversariante_model.dart';
import 'package:ecc/app/modules/encontrista/model/encontrista_model.dart';
import 'package:ecc/app/modules/usuarios/controllers/usuarios_controller.dart';
import 'package:ecc/app/modules/usuarios/model/usuario_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio2/dio2.dart' as dio;
import 'package:intl/intl.dart';

class EncontristaController extends GetxController {
  EncontristaModel? encontristaModel;
  ConfigController configController = Get.put(ConfigController());
  UsuariosController usuariosController = Get.put(UsuariosController());
  Rx<bool> isInitialized = false.obs;
  Rx<GlobalKey<FormState>> formKeyEsposo = GlobalKey<FormState>().obs;
  RxList<EncontristaModel> lista = <EncontristaModel>[].obs;

  List<EncontristaAniversariante> listaAniversariantes = [];

  static final db = FirebaseFirestore.instance.collection('encontrista');
  static final dbFilhos =
      FirebaseFirestore.instance.collection('encontrista_filhos');

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

  Stream<QuerySnapshot> getLista2() {
    return db.orderBy('esposa.nome', descending: false).snapshots();
  }

  void fillListaAniversario(QueryDocumentSnapshot<Map<String, dynamic>> element,
      String campo, String nome, String detalhe, String tipoAniversario) {
    var d = element[campo].toDate();
    listaAniversariantes.add(EncontristaAniversariante(
        nome: nome,
        detalhes: detalhe,
        dia: DateTime(DateTime.now().year, d.month, d.day),
        diaSemana: DateFormat('EEEE', 'pt-br').format(d),
        tipo: tipoAniversario));
  }

  getListaAniversariantes(int mes) async {
    //var esposa = await
    getBaseListAniversario('esposa.nascimento', mes).then(
      (value) => value.forEach(
        (element) {
          for (var i = 0; i < element.docs.length; i++) {
            var e = element.docs[i];
            fillListaAniversario(e, 'esposa.nascimento', e['esposa.nome'],
                e['marido.nome'], 'Natalicio');
          }
        },
      ),
    );

    getBaseListAniversario('marido.nascimento', mes).then(
      (value) => value.forEach(
        (element) {
          for (var i = 0; i < element.docs.length; i++) {
            var e = element.docs[i];
            fillListaAniversario(element.docs[i], 'marido.nascimento',
                e['marido.nome'], e['esposa.nome'], 'Natalicio');
          }
        },
      ),
    );

    getBaseListAniversario('casamento.data', mes).then(
      (value) => value.forEach(
        (element) {
          for (var i = 0; i < element.docs.length; i++) {
            var e = element.docs[i];
            fillListaAniversario(e, 'casamento.data', e['esposa.nome'],
                e['marido.nome'] + ' & ' + e['esposa.nome'], 'Casamento');
          }
        },
      ),
    );
    dbFilhos.where('mesAniversario', isEqualTo: mes).snapshots().forEach(
      (element) {
        for (var i = 0; i < element.docs.length; i++) {
          var e = element.docs[i];
          fillListaAniversario(
              e, 'data_nascimento', e['nome'], 'pais esposa.nome', 'Filhos');
        }
      },
    );
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getBaseListAniversario(
      String chave, int mes) async {
    return db.where(chave, isEqualTo: mes).snapshots();
  }

  Future<bool> get(String id) async {
    try {
      await Firebase.initializeApp();
      await db
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

  gerarDadosTeste(BuildContext context) async {
    print('enrtrei no get');
    UsuariosModel usuariosModelAtivo = usuariosController.usuarioAtivo!.value;
    try {
      dio.Response response = await dio.Dio()
          .get("https://geradorbrasileiro.com/api/faker/pessoa?limit=150");
      // print(response.data['values']);
      print('tamanho ${response.data['values'].length}');
      for (var i = 0; i <= response.data['values'].length - 1; i++) {
        usuariosController.usuarioAtivo!.value = UsuariosModel(
            nome: 'casal$i',
            paroquia: 141,
            ultimoAcesso: DateTime.now(),
            grupo: 2,
            bloqueado: false,
            emails: [Emails(email: '')]);
        // ignore: use_build_context_synchronously
        await usuariosController.addUser(context, 'casal$i', '123456');
        final random = Random();
        print(DateFormat('dd/MM/yyyy')
            .parse(response.data['values'][i]['dataNascimento']));
        var parsedDate = DateFormat('dd/MM/yyyy')
            .parse(response.data['values'][i]['dataNascimento']);
        print(parsedDate);
        encontristaModel = EncontristaModel(
            marido: Marido(
                nome: response.data['values'][i]['pai'],
                photo: 'photo',
                nascimento: parsedDate
                    .subtract(Duration(days: random.nextInt(8000 - 100))),
                telefone: ' ',
                email: ' '),
            esposa: Esposa(
                nome: response.data['values'][i]['mae'],
                photo: '',
                nascimento: parsedDate
                    .subtract(Duration(days: random.nextInt(10000 - 100))),
                telefone: '',
                email: ''),
            casamento: Casamento(
                data: parsedDate.subtract(Duration(days: random.nextInt(5000))),
                igreja: ''),
            endereco: Endereco(
                logradouro: response.data['values'][i]['endereco']
                    ['logradouro'],
                bairro: response.data['values'][i]['endereco']['bairro'],
                cidade: response.data['values'][i]['endereco']['cidade'],
                estado: response.data['values'][i]['endereco']['estado'],
                cep: int.parse(response.data['values'][i]['endereco']['cep']
                    .toString()
                    .replaceAll('-', '')),
                complemento: response.data['values'][i]['endereco']
                    ['complemento']),
            filhos: [
              Filhos(
                nome: response.data['values'][i]['nome'],
                dataNascimento: parsedDate,
                sexo: '',
                owner: usuariosController.usuarioAtivo!.value.nome,
              ),
              Filhos(
                  nome: '',
                  dataNascimento: parsedDate,
                  sexo: '',
                  owner: usuariosController.usuarioAtivo!.value.nome),
              Filhos(
                  nome: '',
                  dataNascimento: parsedDate,
                  sexo: '',
                  owner: usuariosController.usuarioAtivo!.value.nome),
              Filhos(
                  nome: '',
                  dataNascimento: parsedDate,
                  sexo: '',
                  owner: usuariosController.usuarioAtivo!.value.nome),
            ],
            encontro: [
              Encontro(equipe: '', ano: 0, coordenador: false, observacao: '')
            ]);
        gravar();
        print('gravou casal$i');
        print(response.data['values'][i]['mae']);
        print(response.data['values'][i]['pai']);
      }
    } catch (e) {
      print('erro $e');
    }
  }

  Future<bool> gravar() async {
    try {
      await Firebase.initializeApp();
      await db
          .doc(usuariosController.usuarioAtivo!.value.nome)
          .set(encontristaModel!.toJson());
      for (var i = 0; i < encontristaModel!.filhos.length; i++) {
        final element = encontristaModel!.filhos[i];
        element.owner = usuariosController.usuarioAtivo!.value.nome.trim();
        await dbFilhos
            .doc(
                '${usuariosController.usuarioAtivo!.value.nome.trim()}_filho$i')
            .set(element.toJson());
      }

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
          Filhos(
              nome: '',
              dataNascimento: DateTime(1900),
              sexo: '',
              owner: usuariosController.usuarioAtivo!.value.nome),
          Filhos(
              nome: '',
              dataNascimento: DateTime(1900),
              sexo: '',
              owner: usuariosController.usuarioAtivo!.value.nome),
          Filhos(
              nome: '',
              dataNascimento: DateTime(1900),
              sexo: '',
              owner: usuariosController.usuarioAtivo!.value.nome),
          Filhos(
              nome: '',
              dataNascimento: DateTime(1900),
              sexo: '',
              owner: usuariosController.usuarioAtivo!.value.nome),
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
