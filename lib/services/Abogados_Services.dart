import 'dart:convert';

import '../models/Abogados_Model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class AbogadosService {
  AbogadosService();

  Future<List<Abogado>?> getAbogado() async {
    List<Abogado> result = [];

    try {
      var url =
          Uri.https('demo4364339.mockable.io', '/api/abogados');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {  
          return result;
        } else {
          List<dynamic> ListBody = json.decode(response.body);
          for (var item in ListBody) {
            var NewAbogado = Abogado.fromJson(item);
            result.add(NewAbogado);
          }
        }
      } else {
        developer.log('Error en la solicitud HTTP: ${response.statusCode}',
            error: response.body);
      }
      return result;
    } catch (ex) {
      developer.log('Error en la solicitud HTTP:$ex');
      return null;
    }
  }
}