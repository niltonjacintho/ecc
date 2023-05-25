import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio2/dio2.dart' as dio;
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class Paroquia {
  String? nome = '';
  String? detalhes = '';
  int id = 0;
  String? long = '';
  String? lat = '';

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'detalhes': detalhes,
      'id': id,
      'longitude': long,
      'latitude': lat,
    };
  }
}

class HttpImportController extends GetxController {
  String _urlListaParoquia(int pagina) {
    return 'https://www.arqrio.com.br/curia/paroquias.php?pagina=$pagina&p=&v=';
  }

  importarListaParoquias() async {
    bool prosseguir = true;
    int pagina = 1;
    int posicao = 0;
    int inicio = 0;
    String linha = '';
    while (prosseguir) {
      try {
        dio.Response response = await dio.Dio().get(_urlListaParoquia(pagina));
        prosseguir =
            response.data.toString().contains('onclick="recuperaDetalhes(');
        if (prosseguir) {
          linha = response.data.toString().substring(response.data
              .toString()
              .indexOf('<div class="panel-group" id="accordion">'));
          linha = linha.substring(0, linha.indexOf('</form>'));
//get Id
          extrairParoquias(linha);
          posicao =
              response.data.toString().indexOf('onclick="recuperaDetalhes(');
          print(pagina);
        }
        pagina++;
      } catch (e) {
        print(e);
      }
    }
  }

  void extrairParoquias(String l) async {
    List<Paroquia> listParoquia = [];
    while (l.contains('recuperaDetalhes')) {
      Paroquia paroquia = Paroquia();
      l = l.substring(l.indexOf('recuperaDetalhes'));
      paroquia.id = int.parse(
          l.substring(0, l.indexOf("')")).split(',')[1].replaceAll("'", ""));
      paroquia.nome =
          l.substring(l.indexOf('">') + 2, l.indexOf("</a>")).trim();
      l = l.substring(l.indexOf("</a>"));
      await getParoquiaDetails(paroquia.id)
          .then((value) => paroquia.detalhes = value);

      if (paroquia.detalhes!.contains('Mapa')) {
        String tempLinha = paroquia.detalhes!.substring(
          paroquia.detalhes!.indexOf('Mapa'),
        );

        tempLinha = tempLinha.substring(
          0,
          tempLinha.indexOf('><'),
        );

        paroquia.lat = tempLinha.substring(5).split(",")[0].replaceAll("'", "");
        paroquia.long =
            tempLinha.substring(5).split(",")[1].replaceAll("'", "");

        gravarParoquia(paroquia);
        print(tempLinha);
      }
      // print(' id = $id e nome = $nome');
    }
  }

  Future<String> getParoquiaDetails(int id) async {
    dio.Response response = await dio.Dio().get(
        'https://www.arqrio.com.br/curia/ajaxParoquiasRecuperarDetalhes.php?id=$id');
    return response.data.toString().trim();
  }

  gravarParoquia(Paroquia paroquia) async {
    try {
      await Firebase.initializeApp();
      final CollectionReference dadosRef = FirebaseFirestore.instance.collection('paroquias');

//      dadosRef.doc(paroquia.id.toString()).get().then((value) async {
          await dadosRef.doc(paroquia.id.toString()).set(paroquia.toJson())

  //    }

          //  await dadosRef.add(noticiasEditController.noticiasModel.value.toJson());
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(content: Text('Dados salvos com sucesso!')),
          )
    } catch (e) {
      print(e);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Erro ao salvar dados: $e')),
      // );
      //
    }
  }
}
