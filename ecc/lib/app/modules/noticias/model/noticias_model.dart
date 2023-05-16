class NoticiasModel {
  String? data;
  String? titulo;
  String? subtitulo;
  String? noticia;
  String? autor;
  String? publicarDe;
  String? publicarAte;
  String? urlImagemPrincipal;
  List<Imagem>? imagem;

  NoticiasModel(
      {this.data,
      this.titulo,
      this.subtitulo,
      this.noticia,
      this.autor,
      this.publicarDe,
      this.publicarAte,
      this.urlImagemPrincipal,
      this.imagem});

  NoticiasModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    titulo = json['titulo'];
    subtitulo = json['subtitulo'];
    noticia = json['noticia'];
    autor = json['autor'];
    publicarDe = json['publicar_de'];
    publicarAte = json['publicar_ate'];
    urlImagemPrincipal = json['urlImagemPrincipal'];
    if (json['imagem'] != null) {
      imagem = <Imagem>[];
      json['imagem'].forEach((v) {
        imagem!.add(Imagem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['titulo'] = titulo;
    data['subtitulo'] = subtitulo;
    data['noticia'] = noticia;
    data['autor'] = autor;
    data['publicar_de'] = publicarDe;
    data['publicar_ate'] = publicarAte;
    data['urlImagemPrincipal'] = urlImagemPrincipal;
    if (imagem != null) {
      data['imagem'] = imagem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Imagem {
  String? nome;
  String? endereco;

  Imagem({this.nome, this.endereco});

  Imagem.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    endereco = json['endereco'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['endereco'] = endereco;
    return data;
  }
}
