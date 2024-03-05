import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListaTareasAbogados extends StatelessWidget {
  const ListaTareasAbogados({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // Consulta las tareas de Firestore
      stream: FirebaseFirestore.instance.collection('tareas').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error al cargar las tareas'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // Muestra las tareas en un ListView
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final tarea = snapshot.data!.docs[index];
            return TareaAbogadoItem(tarea: tarea);
          },
        );
      },
    );
  }
}

class TareaAbogadoItem extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> tarea;

  const TareaAbogadoItem({Key? key, required this.tarea}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: tarea['completada'],
          onChanged: (value) {
            // Actualiza el estado de completada en Firestore
            tarea.reference.update({'completada': value});
          },
        ),
        title: Text(tarea['titulo']),
        subtitle: Text(tarea['descripcion']),
        trailing: Text(tarea['fecha']),
      ),
    );
  }
}

class CrearTareaAbogado extends StatefulWidget {
  const CrearTareaAbogado({Key? key}) : super(key: key);

  @override
  _CrearTareaAbogadoState createState() => _CrearTareaAbogadoState();
}

class _CrearTareaAbogadoState extends State<CrearTareaAbogado> {
  late TextEditingController _tituloController;
  late TextEditingController _descripcionController;
  late TextEditingController _fechaController;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController();
    _descripcionController = TextEditingController();
    _fechaController = TextEditingController();
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _fechaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Tarea')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _fechaController,
              decoration: InputDecoration(labelText: 'Fecha'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () { // Guarda la nueva tarea en Firestore
                FirebaseFirestore.instance.collection('tareas').add({
                  'titulo': _tituloController.text,
                  'descripcion': _descripcionController.text,
                  'fecha': _fechaController.text,
                  'completada': false,
                }).then((value) { // Limpia los campos después de guardar la tarea
                  _tituloController.clear();
                  _descripcionController.clear();
                  _fechaController.clear();
                  // Muestra un mensaje de éxito
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tarea creada correctamente')),
                  );
                }).catchError((error) {  // Muestra un mensaje si ocurre un error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al crear la tarea')),
                  );
                });
              },
              child: Text('Crear Tarea'),
            ),
          ],
        ),
      ),
    );
  }
}
