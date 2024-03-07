import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Abogados_Model.dart';

class AbogadosService {
  AbogadosService();

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Abogado>> getAbogados() async {
    List<Abogado> abogados = [];

    try {
      CollectionReference collectionReferenceEstudios =
          db.collection('abogados');
      QuerySnapshot queryEstudios = await collectionReferenceEstudios.get();
      queryEstudios.docs.forEach((doc) {
        Abogado abogado = Abogado.fromJson(doc.data() as Map<String, dynamic>);
        abogados.add(abogado);
      });

      return abogados;
    } catch (error) {
      print('Error al cargar datos desde Firestore: $error');
      throw Exception('Error al cargar datos desde Firestore: $error');
    }
  }

  Future<List<Abogado>> getAbogadosByType(String tipo) async {
    try {
      QuerySnapshot query = await db
          .collection('abogados')
          .where('especializacion', isEqualTo: tipo.toLowerCase())
          .get();

      List<Abogado> abogados = query.docs.map((doc) {
        return Abogado.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return abogados;
    } catch (error) {
      print('Error al buscar abogados por tipo: $error');
      throw Exception('Error al buscar abogados por tipo: $error');
    }
  }
}
