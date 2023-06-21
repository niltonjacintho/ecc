class EncontristaAniversariante {
  EncontristaAniversariante({
    required this.nome,
    required this.detalhes,
    required this.dia,
    required this.diaSemana,
    required this.tipo,
  });
  late final String nome;
  late final String detalhes;
  late final DateTime dia;
  late final String diaSemana;
  late final String tipo;

  EncontristaAniversariante.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    detalhes = json['detalhes'];
    dia = json['dia'];
    diaSemana = json['diaSemana'];
    tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nome'] = nome;
    data['detalhes'] = detalhes;
    data['dia'] = dia;
    data['diaSemana'] = diaSemana;
    data['tipo'] = tipo;
    return data;
  }
}
