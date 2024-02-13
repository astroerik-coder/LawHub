import 'package:flutter/material.dart';

class ListaTareasAbogadosFake extends StatelessWidget {
  const ListaTareasAbogadosFake({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tareasFake = [
      {
        "titulo": "Reunión con cliente - Juan Pérez",
        "descripcion": "Discutir el caso legal y próximos pasos.",
        "fecha": "2024-02-15",
        "tipo": "Reunión",
        "completada": false,
      },
      {
        "titulo": "Investigar jurisprudencia",
        "descripcion": "Analizar casos similares para preparar la defensa.",
        "fecha": "2024-02-16",
        "tipo": "Investigación",
        "completada": true,
      },
      {
        "titulo": "Presentar escrito judicial",
        "descripcion": "Redactar y enviar el documento a la corte.",
        "fecha": "2024-02-17",
        "tipo": "Tarea",
        "completada": false,
      },
      {
        "titulo": "Reunión con cliente - María López",
        "descripcion": "Revisar el avance del caso y responder preguntas.",
        "fecha": "2024-02-17",
        "tipo": "Reunión",
        "completada": false,
      },
      {
        "titulo": "Preparar argumentos para audiencia",
        "descripcion": "Organizar la estrategia de defensa para la próxima audiencia.",
        "fecha": "2024-02-18",
        "tipo": "Preparación",
        "completada": false,
      },
    ];

    return ListView.builder(
      itemCount: tareasFake.length,
      itemBuilder: (context, index) {
        return TareaAbogadoItemFake(tarea: tareasFake[index]);
      },
    );
  }
}

class TareaAbogadoItemFake extends StatelessWidget {
  final Map<String, dynamic> tarea;

  const TareaAbogadoItemFake({Key? key, required this.tarea}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: tarea['completada'],
          onChanged: (value) {},
        ),
        title: Text(tarea['titulo']),
        subtitle: Text(tarea['descripcion']),
        trailing: Text(tarea['fecha']),
      ),
    );
  }
}
