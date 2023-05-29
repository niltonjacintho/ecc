class GruposModel {
  GruposModel({
    required this.id,
    required this.nome,
    required this.isadmin,
    required this.iseditor,
  });
  late final int id;
  late final String nome;
  late final bool isadmin;
  late final bool iseditor;

  GruposModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    isadmin = json['isadmin'];
    iseditor = json['iseditor'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['isadmin'] = isadmin;
    data['iseditor'] = iseditor;
    return data;
  }
}
