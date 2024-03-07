import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'citas_detalles.dart'; // Importa la clase CitasDetalles

class ListaCitasAbogados extends StatelessWidget {
  const ListaCitasAbogados({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('citas').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Muestra un indicador de carga mientras se cargan los datos
        }
        if (snapshot.hasError) {
          return Text('Error al cargar las citas: ${snapshot.error}');
        }
        final List<DocumentSnapshot> citas = snapshot.data!.docs;

        if (citas.isEmpty) {
          // Si no hay citas disponibles, mostrar un mensaje y un icono
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/descanso.png'), 
                SizedBox(height: 20),
                Text('No tienes citas disponibles',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: citas.length,
          itemBuilder: (context, index) {
            final cita = citas[index].data() as Map<String, dynamic>;
            return CitaAbogadoItem(cita: cita);
          },
        );
      },
    );
  }
}

class CitaAbogadoItem extends StatelessWidget {
  final Map<String, dynamic> cita;

  const CitaAbogadoItem({Key? key, required this.cita}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convertir el objeto Timestamp a DateTime
    DateTime fechaHoraCita = (cita['fechaHoraCita'] as Timestamp).toDate();
    
    // Formatear la fecha y hora en un formato legible
    String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm').format(fechaHoraCita);

    return Card(
      child: ListTile(
        title: Text('Abogado: ${cita['nombreAbogado']}'),
        subtitle: Text('Con: ${cita['nombreUsuario']}\nFecha: $formattedDateTime'), // Detalles de la persona y fecha
        onTap: () {
          // Navegar a la pantalla de detalles al hacer clic en la cita
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CitasDetalles(cita: cita)),
          );
        },
      ),
    );
  }
}
