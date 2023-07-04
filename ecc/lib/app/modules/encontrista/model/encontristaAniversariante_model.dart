class EncontristaAniversariante {
  EncontristaAniversariante({
    required this.nome,
    required this.detalhes,
    required this.data,
    required this.campo,
  });
  late final String nome;
  late final String detalhes;
  late final String data;
  late final String campo;

  EncontristaAniversariante.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    detalhes = json['detalhes'];
    data = json['data'];
    data = json['campo'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nome'] = nome;
    data['detalhes'] = detalhes;
    data['data'] = data;
    data['campo'] = campo;
    return data;
  }
}
