class UsuariosModel {
  UsuariosModel({
    required this.nome,
    required this.paroquia,
    required this.ultimoAcesso,
    required this.grupo,
    required this.bloqueado,
    required this.emails,
  });
  late final String nome;
  late final int paroquia;
  late String senha;
  late final DateTime ultimoAcesso;
  late final int grupo;
  late final bool bloqueado;
  late final List<Emails> emails;

  UsuariosModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    paroquia = json['paroquia'];
    senha = '';
    ultimoAcesso = json['ultimoAcesso'];
    grupo = json['grupo'];
    bloqueado = json['bloqueado'];
    emails = List.from(json['emails']).map((e) => Emails.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nome'] = nome;
    data['paroquia'] = paroquia;
    data['senha'] = senha;
    data['ultimoAcesso'] = ultimoAcesso;
    data['grupo'] = grupo;
    data['bloqueado'] = bloqueado;
    data['emails'] = emails.map((e) => e.toJson()).toList();
    return data;
  }
}

class Emails {
  Emails({
    required this.email,
  });
  late String email;

  Emails.fromJson(Map<String, dynamic> json) {
    email = '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }
}
