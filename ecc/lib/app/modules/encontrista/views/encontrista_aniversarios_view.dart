import 'package:ecc/app/modules/encontrista/controllers/encontrista_controller.dart';
import 'package:ecc/app/modules/encontrista/model/encontristaAniversariante_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EncontristaAniversariosPage extends GetView<EncontristaController> {
  const EncontristaAniversariosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EncontristaAniversariosPage')),
      body: SafeArea(
        child: StreamBuilder<List<EncontristaAniversariante>>(
          stream: Stream.fromFuture(
              controller.getListaAniversariantes(1)), // O stream de dados
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final listaAniversariantes = snapshot.data!;
              return ListView.builder(
                itemCount: listaAniversariantes.length,
                itemBuilder: (context, index) {
                  final aniversariante = listaAniversariantes[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(aniversariante.tipo.substring(0, 1)),
                      ),
                      title: Text(
                        aniversariante.nome,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(aniversariante.detalhes),
                      trailing: Text(aniversariante.diaSemana),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Text('Erro ao carregar os dados.');
            } else {
              return const CircularProgressIndicator(); // Indicador de carregamento enquanto espera pelos dados
            }
          },
        ),
      ),
    );
  }
}
