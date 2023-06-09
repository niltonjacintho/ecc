import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecc/app/modules/paroquias/model/paroquias_model.dart';
import 'package:get/get.dart';

class ParoquiasController extends GetxController {
  //TODO: Implement ParoquiasController

  ParoquiasModel paroquiasModel = Get.put(ParoquiasModel(
      nome: '', id: '', detalhes: '', latitude: '', longitude: ''));
  Rx<bool> isInitialized = false.obs;
  List<ParoquiasModel> lista = [];

  Future<List<ParoquiasModel>> restoreParoquiaListFromFirestore() async {
    // Reference to the "paroquia" collection in Firestore
    CollectionReference paroquiaCollection =
        FirebaseFirestore.instance.collection('paroquias');

    // Retrieve all documents from the collection
    QuerySnapshot snapshot = await paroquiaCollection.get();

    // List to store the restored ParoquiaModel objects
    lista = [];

    final allData = snapshot.docs.map((doc) {
      var data = doc.data();
    });

    // Iterate over the snapshots and restore the ParoquiaModel objects
    for (var data in snapshot.docs) {
      // Map<String, dynamic> data = element.get('id');
      // Create a new ParoquiaModel object and add it to the list
      ParoquiasModel paroquia = ParoquiasModel(
        nome: data['nome'],
        id: data['id'].toString(),
        detalhes: data['detalhes'],
        latitude: data['latitude'],
        longitude: data['longitude'],
      );
      lista.add(paroquia);
    }
    isInitialized.value = true;
    return lista;
  }

  @override
  Future<void> onInit() async {
    await restoreParoquiaListFromFirestore();
    super.onInit();
  }
}
