import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
//Lista de estudios juridicos
Future<List> getEstudiosJuridicos() async {
  List estudiosJuridicos = [];

  CollectionReference collectionReferenceEstudios =
      db.collection('estudio_juridico');
  QuerySnapshot queryEstudios = await collectionReferenceEstudios.get();
  queryEstudios.docs.forEach((doc) {
    estudiosJuridicos.add(doc.data());
  });

  return estudiosJuridicos;
}

//Lista de abogados
Future<List> getAbogados() async {
  List abogados = [];

  CollectionReference collectionReferenceEstudios = db.collection('abogados');
  QuerySnapshot queryEstudios = await collectionReferenceEstudios.get();
  queryEstudios.docs.forEach((doc) {
    abogados.add(doc.data());
  });

  return abogados;
}
