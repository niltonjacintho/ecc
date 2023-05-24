class EncontristaModel {
  Encontrista? encontrista;

  EncontristaModel({this.encontrista});

  EncontristaModel.fromJson(Map<String, dynamic> json) {
    encontrista = json['encontrista'] != null
        ? Encontrista.fromJson(json['encontrista'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (encontrista != null) {
      data['encontrista'] = encontrista?.toJson();
    }
    return data;
  }
}

class Encontrista {
  Marido? marido;
  Marido? esposa;
  Endereco? endereco;
  Casamento? casamento;
  List<Filhos>? filhos;
  List<Encontro>? encontro;

  Encontrista(
      {this.marido,
      this.esposa,
      this.endereco,
      this.casamento,
      this.filhos,
      this.encontro});

  Encontrista.fromJson(Map<String, dynamic> json) {
    marido = json['marido'] != null ? Marido.fromJson(json['marido']) : null;
    esposa = json['esposa'] != null ? Marido.fromJson(json['esposa']) : null;
    endereco =
        json['endereco'] != null ? Endereco.fromJson(json['endereco']) : null;
    casamento = json['casamento'] != null
        ? Casamento.fromJson(json['casamento'])
        : null;
    if (json['filhos'] != null) {
      filhos = [];
      // List<Filhos>();
      json['filhos'].forEach((v) {
        filhos!.add(Filhos.fromJson(v));
      });
    }
    if (json['encontro'] != null) {
      encontro = [];
      json['encontro'].forEach((v) {
        encontro!.add(Encontro.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (marido != null) {
      data['marido'] = marido!.toJson();
    }
    if (esposa != null) {
      data['esposa'] = esposa!.toJson();
    }
    if (endereco != null) {
      data['endereco'] = endereco!.toJson();
    }
    if (casamento != null) {
      data['casamento'] = casamento!.toJson();
    }
    if (filhos != null) {
      data['filhos'] = filhos!.map((v) => v.toJson()).toList();
    }
    if (encontro != null) {
      data['encontro'] = encontro!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Marido {
  String? nome;
  String? photo;
  String? nascimento;
  String? telefone;
  String? email;

  Marido({this.nome, this.photo, this.nascimento, this.telefone, this.email});

  Marido.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    photo = json['photo'];
    nascimento = json['nascimento'];
    telefone = json['telefone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['photo'] = photo;
    data['nascimento'] = nascimento;
    data['telefone'] = telefone;
    data['email'] = email;
    return data;
  }
}

class Endereco {
  String? logradouro;
  String? bairro;
  String? cidade;
  String? estado;
  int? cep;
  String? complemento;

  Endereco(
      {this.logradouro,
      this.bairro,
      this.cidade,
      this.estado,
      this.cep,
      this.complemento});

  Endereco.fromJson(Map<String, dynamic> json) {
    logradouro = json['logradouro'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    estado = json['estado'];
    cep = json['cep'];
    complemento = json['complemento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  String? data;
  String? igreja;

  Casamento({this.data, this.igreja});

  Casamento.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    igreja = json['igreja'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['igreja'] = igreja;
    return data;
  }
}

class Filhos {
  String? nome;
  String? dataNascimento;
  String? sexo;

  Filhos({this.nome, this.dataNascimento, this.sexo});

  Filhos.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    dataNascimento = json['data_nascimento'];
    sexo = json['sexo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['data_nascimento'] = dataNascimento;
    data['sexo'] = sexo;
    return data;
  }
}

class Encontro {
  String? equipe;
  int? ano = 0;
  bool? coordenador;
  String? observacao;

  Encontro({this.equipe, this.ano, this.coordenador, this.observacao});

  Encontro.fromJson(Map<String, dynamic> json) {
    equipe = json['equipe'];
    ano = json['ano'];
    coordenador = json['coordenador'];
    observacao = json['observacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['equipe'] = equipe;
    data['ano'] = ano;
    data['coordenador'] = coordenador;
    data['observacao'] = observacao;
    return data;
  }
}
