class EncontristaModel {
  EncontristaModel({
    required this.encontrista,
  });
  late final Encontrista encontrista;

  EncontristaModel.fromJson(Map<String, dynamic> json) {
    encontrista = Encontrista.fromJson(json['encontrista']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['encontrista'] = encontrista.toJson();
    return data;
  }
}

class Encontrista {
  late Marido marido = Marido();
  Esposa esposa = Esposa();
  Endereco endereco = Endereco();
  Casamento casamento = Casamento();
  List<Filhos> filhos = [Filhos()];
  List<Encontro> encontro = [Encontro()];
  Encontrista();

  Encontrista.fromJson(Map<String, dynamic> json) {
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
  late String nome;
  late String photo;
  late DateTime nascimento = DateTime(2000);
  late String telefone;
  late String email;
  Marido({
    this.nome = '',
    this.photo = '',
    DateTime? nascimento,
    this.telefone = '',
    this.email = '',
  });

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
  late String nome;
  late String photo;
  late DateTime? nascimento;
  late String telefone;
  late String email;
  Esposa({
    this.nome = '',
    this.photo = '',
    DateTime? nascimento,
    this.telefone = '',
    this.email = '',
  });

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
  late String logradouro;
  late String bairro;
  late String cidade;
  late String estado;
  late int cep;
  late String complemento;

  Endereco({
    this.logradouro = '',
    this.bairro = '',
    this.cidade = '',
    this.estado = '',
    this.cep = 0,
    this.complemento = '',
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
  late DateTime? data = DateTime(2000);
  late String igreja;
  Casamento({
    DateTime? data,
    this.igreja = '',
  });

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
  late String nome;
  late DateTime? dataNascimento = DateTime(2000);
  late String sexo;
  Filhos({
    this.nome = '',
    DateTime? dataNascimento,
    this.sexo = '',
  });

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
  late String equipe = '';
  late int ano = 2000;
  late bool coordenador = '';
  late String observacao = '';
  Encontro({
    this.equipe = '',
    this.ano = 2000,
    this.coordenador = '',
    this.observacao = '',
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
