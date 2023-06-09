class ParoquiasModel {
  ParoquiasModel({
    required this.nome,
    required this.id,
    required this.detalhes,
    required this.latitude,
    required this.longitude,
  });
  late final String nome;
  late final String id;
  late final String detalhes;
  late final String latitude;
  late final String longitude;
  late final String? shortName = nome
      .split('-')[0]
      .toLowerCase()
      .replaceAll('Paroquia', '')
      .replaceAll('Paróquia', '')
      .toUpperCase();
  late final String? bairro = nome.split('-')[1].toUpperCase();

  ParoquiasModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    id = json['id'];
    detalhes = json['detalhes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nome'] = nome;
    data['id'] = id;
    data['detalhes'] = detalhes;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
