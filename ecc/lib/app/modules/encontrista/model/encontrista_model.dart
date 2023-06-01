class EncontristaModel {
  EncontristaModel({
    required this.marido,
    required this.esposa,
    required this.endereco,
    required this.casamento,
    required this.filhos,
    required this.encontro,
  });
  late final Marido marido;
  late final Esposa esposa;
  late final Endereco endereco;
  late final Casamento casamento;
  late final List<Filhos> filhos;
  late final List<Encontro> encontro;

  EncontristaModel.fromJson(Map<String, dynamic> json) {
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
    data['filhos'] = filhos.map((e) => e.toJson()).toList();
    data['encontro'] = encontro.map((e) => e.toJson()).toList();
    return data;
  }
}

class Marido {
  Marido({
    required this.nome,
    required this.photo,
    required this.nascimento,
    required this.telefone,
    required this.email,
  });
  late final String nome;
  late final String photo;
  late final DateTime nascimento;
  late final String telefone;
  late final String email;

  Marido.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    photo = json['photo'];
    nascimento = json['nascimento'];
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
  // late final String? nome;
  // late final String photo;
  // late final DateTime nascimento;
  // late final String telefone;
  // late final String email;

  Esposa.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    photo = json['photo'];
    nascimento = json['nascimento'];
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
    return data;
  }
}

class Endereco {
  Endereco({
    required this.logradouro,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.cep,
    required this.complemento,
  });
  late final String logradouro;
  late final String bairro;
  late final String cidade;
  late final String estado;
  late final int cep;
  late final String complemento;

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
  Casamento({
    required this.data,
    required this.igreja,
  });
  late final DateTime data;
  late final String igreja;

  Casamento.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    igreja = json['igreja'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['data'] = data;
    data['igreja'] = igreja;
    return data;
  }
}

class Filhos {
  Filhos({
    required this.nome,
    required this.dataNascimento,
    required this.sexo,
  });
  late final String nome;
  late final DateTime dataNascimento;
  late final String sexo;

  Filhos.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    dataNascimento = json['data_nascimento'];
    sexo = json['sexo'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nome'] = nome;
    data['data_nascimento'] = dataNascimento;
    data['sexo'] = sexo;
    return data;
  }
}

class Encontro {
  Encontro({
    required this.equipe,
    required this.ano,
    required this.coordenador,
    required this.observacao,
  });
  late final String equipe;
  late final int ano;
  late final bool coordenador;
  late final String observacao;

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
