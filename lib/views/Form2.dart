import 'package:flutter/material.dart';
import '../models/Abogados_Model.dart';
import '../services/Abogados_Services.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Form2 extends StatefulWidget {
  const Form2({Key? key}) : super(key: key);

  @override
  State<Form2> createState() => _Form2();
}

class _Form2 extends State<Form2> {
  final AbogadosService _abogadosService = AbogadosService();

  List<Abogado>? _lista;
  loadAbogagos() async {
    AbogadosService service = AbogadosService();
    _lista = await service.getAbogado();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    loadAbogagos();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: _lista == null || _lista!.isEmpty
          ? Center(
              child: SizedBox.square(
                dimension: 50.0,
                child: CircularProgressIndicator(),
              ),
            )
          : ListView(
              children: _lista!
                  .map((e) => Card(
                        child: ListTile(
                          title: Text(e.nombre.toString()),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.contacto.correo.toString()),
                              Text(e.disponibilidad.horario.toString()),
                              Text(e.tarifasHonorarios.monto.toString()),
                              
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
    );
  }
}
