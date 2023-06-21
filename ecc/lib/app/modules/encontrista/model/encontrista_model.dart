import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EncontristaModel {
  Marido marido = Marido(
      nome: '', photo: '', nascimento: DateTime(2000), telefone: '', email: '');
  Esposa esposa = Esposa(
      nome: '', photo: '', nascimento: DateTime(2000), telefone: '', email: '');
  Endereco endereco = Endereco(
      logradouro: '',
      bairro: '',
      cidade: '',
      estado: '',
      cep: 0,
      complemento: '');
  Casamento casamento = Casamento(data: DateTime(2000), igreja: '');
  List<Filhos> filhos = [
    Filhos(nome: '', dataNascimento: DateTime(2000), sexo: '', owner: '')
  ];
  List<Encontro> encontro = [
    Encontro(equipe: '', ano: 2000, coordenador: false, observacao: '')
  ];
  EncontristaModel({
    required this.marido,
    required this.esposa,
    required this.endereco,
    required this.casamento,
    required this.filhos,
    required this.encontro,
  });

  EncontristaModel.fromJson(Map<String, dynamic> json) {
    marido = Marido.fromJson(json['marido']);
    esposa = Esposa.fromJson(json['esposa']);
    endereco = Endereco.fromJson(json['endereco']);
    casamento = Casamento.fromJson(json['casamento']);
    filhos = List.from(json['filhos']).map((e) => Filhos.fromJson(e)).toList();
    encontro =
        List.from(json['encontro']).map((e) => Encontro.fromJson(e)).toList();
  }

  fromJson(Map<String, dynamic> json) {
    marido = Marido.fromJson(json['marido']);
    esposa = Esposa.fromJson(json['esposa']);
    endereco = Endereco.fromJson(json['endereco']);
    casamento = Casamento.fromJson(json['casamento']);
    filhos = List.from(json['filhos']).map((e) => Filhos.fromJson(e)).toList();
    encontro =
        List.from(json['encontro']).map((e) => Encontro.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['marido'] = marido.toJson();
    data['esposa'] = esposa.toJson();
    data['endereco'] = endereco.toJson();
    data['casamento'] = casamento.toJson();
    // data['filhos'] = filhos.map((e) => e.toJson()).toList();
    data['encontro'] = encontro.map((e) => e.toJson()).toList();
    return data;

    //};
  }
}

class Marido {
  String nome = ' ';
  String photo = 'photo';
  DateTime nascimento = DateTime(1900);
  String telefone = ' ';
  String email = ' ';
  final int? mesAniversario = 0;
  Marido({
    required this.nome,
    required this.photo,
    required this.nascimento,
    required this.telefone,
    required this.email,
  });

  Marido.fromJson(Map<String, dynamic> json) {
    Timestamp t = json['nascimento'];
    nome = json['nome'];
    photo = json['photo'];
    nascimento = t.toDate();
    telefone = json['telefone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    // initializeDateFormatting('pt_BR', null);
    final data = <String, dynamic>{};
    data['nome'] = nome == '' ? '.setado' : nome;
    data['photo'] = photo == '' ? '.' : photo;
    data['nascimento'] = nascimento;
    data['telefone'] = telefone == '' ? '.' : telefone;
    data['email'] = email == '' ? '.' : email;
    data['mesAniversario'] = nascimento.month;
    data['aniversario'] =
        DateTime(nascimento.day, nascimento.month, DateTime.now().year);
    data['aniversarioDiaSemana'] = DateFormat('EEEE', 'pt-br').format(
        DateTime(nascimento.day, nascimento.month, DateTime.now().year));
    return data;
  }
}

class Esposa {
  String? nome = '';
  String photo = '';
  DateTime nascimento = DateTime(2000);
  String telefone = '';
  String email = '';
  Esposa({
    required this.nome,
    required this.photo,
    required this.nascimento,
    required this.telefone,
    required this.email,
  });

  Esposa.fromJson(Map<String, dynamic> json) {
    Timestamp t = json['nascimento'];
    nome = json['nome'];
    photo = json['photo'];
    nascimento = t.toDate();
    telefone = json['telefone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nome'] = nome;
    data['photo'] = photo;
    data['nascimento'] = nascimento;
    data['telefone'] = telefone;
    data['email'] = email;
    data['mesAniversario'] = nascimento.month;
    data['aniversarioDiaSemana'] = DateFormat('EEEE', 'pt-br').format(
        DateTime(nascimento.day, nascimento.month, DateTime.now().year));

    return data;
  }
}

class Endereco {
  String? logradouro = '';
  String? bairro = '';
  String? cidade = '';
  String? estado = '';
  int? cep = 0;
  String? complemento = '';
  Endereco({
    required this.logradouro,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.cep,
    required this.complemento,
  });

  Endereco.fromJson(Map<String, dynamic> json) {
    logradouro = json['logradouro'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    estado = json['estado'];
    cep = json['cep'];
    complemento = json['complemento'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['logradouro'] = logradouro;
    data['bairro'] = bairro;
    data['cidade'] = cidade;
    data['estado'] = estado;
    data['cep'] = cep;
    data['complemento'] = complemento;
    return data;
  }
}

class Casamento {
  DateTime data = DateTime(2000);
  String igreja = ' ';
  Casamento({
    required this.data,
    required this.igreja,
  });

  Casamento.fromJson(Map<String, dynamic> json) {
    Timestamp t = json['data'];
    data = t.toDate();
    igreja = json['igreja'];
  }

  Map<String, dynamic> toJson() {
    final dataBase = <String, dynamic>{};
    dataBase['data'] = data;
    dataBase['igreja'] = igreja;
    dataBase['mes'] = data.month;
    dataBase['aniversarioDiaSemana'] = DateFormat('EEEE', 'pt-br')
        .format(DateTime(data.day, data.month, DateTime.now().year));

    return dataBase;
  }
}

class Filhos {
  String nome = '';
  DateTime dataNascimento = DateTime(1900);
  String sexo = '';
  String owner = '';
  Filhos({
    required this.nome,
    required this.dataNascimento,
    required this.sexo,
    required this.owner,
  });

  Filhos.fromJson(Map<String, dynamic> json) {
    Timestamp t = json['data_nascimento'];
    nome = json['nome'];
    dataNascimento = t.toDate();
    sexo = json['sexo'];
    owner = json['owner'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nome'] = nome;
    data['data_nascimento'] = dataNascimento;
    data['sexo'] = sexo;
    data['mesAniversario'] = dataNascimento.month;
    data['aniversarioDiaSemana'] = DateFormat('EEEE', 'pt-br').format(DateTime(
        dataNascimento.day, dataNascimento.month, DateTime.now().year));
    data['owner'] = owner;
    return data;
  }
}

class Encontro {
  String equipe = '';
  int ano = 0;
  bool coordenador = false;
  String observacao = '';
  Encontro({
    required this.equipe,
    required this.ano,
    required this.coordenador,
    required this.observacao,
  });

  Encontro.fromJson(Map<String, dynamic> json) {
    equipe = json['equipe'];
    ano = json['ano'];
    coordenador = json['coordenador'];
    observacao = json['observacao'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['equipe'] = equipe;
    data['ano'] = ano;
    data['coordenador'] = coordenador;
    data['observacao'] = observacao;
    return data;
  }
}
