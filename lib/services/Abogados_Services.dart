import 'dart:convert';

import '../models/Abogados_Model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class AbogadosService {
  AbogadosService();

  Future<List<Abogado>?> getAbogados() async {
    List<Abogado> result = [];

    try {
      var url = Uri.https('demo4364339.mockable.io', '/api/abogados');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          return result;
        } else {
          List<dynamic> listBody = json.decode(response.body);
          for (var item in listBody) {
            var newAbogado = Abogado.fromJson(item);
            result.add(newAbogado);
          }
        }
      } else {
        developer.log(
          'Error en la solicitud HTTP: ${response.statusCode}',
          error: response.body,
        );
        throw Exception(
            'No se pudieron cargar los datos: ${response.statusCode}');
      }

      return result;
    } catch (ex, stackTrace) {
      developer.log('Error en la solicitud HTTP : $ex', error: stackTrace);
      throw Exception('No se pudieron cargar los datos: $ex');
    }
  }

  Future<List<Abogado>> getAbogadosByType(String tipo) async {
    final response = await http
        .get(Uri.parse('https://demo4364339.mockable.io/api/abogados'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      List<Abogado> filteredList = responseData
          .map((json) => Abogado.fromJson(json))
          .where((abogado) => abogado.especializacion
              .toLowerCase()
              .contains(tipo.toLowerCase()))
          .toList();
      developer.log(tipo);
      return filteredList;
    } else {
      throw Exception('Error al cargadr datos desde la API');
    }
  }
}
