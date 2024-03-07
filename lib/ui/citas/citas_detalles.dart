import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CitasDetalles extends StatelessWidget {
  final Map<String, dynamic> cita;

  CitasDetalles({required this.cita});

  @override
  Widget build(BuildContext context) {
    // Convertir el objeto Timestamp a DateTime
    DateTime fechaHoraCita = (cita['fechaHoraCita'] as Timestamp).toDate();

    // Formatear la fecha y hora en un formato legible
    String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm').format(fechaHoraCita);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Detalles de la cita',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text(
                'Abogado:',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              subtitle: Text(
                cita['nombreAbogado'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text(
                'Cliente:',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              subtitle: Text(
                cita['nombreUsuario'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text(
                'Fecha y hora:',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              subtitle: Text(
                formattedDateTime,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text(
                'Descripción:',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              subtitle: Text(
                cita['asunto'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/images/reunion.png',
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
