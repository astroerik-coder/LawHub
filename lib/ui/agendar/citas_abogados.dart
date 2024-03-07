import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgendarCitaPage extends StatefulWidget {
  final String nombreAbogado;

  AgendarCitaPage({required this.nombreAbogado});

  @override
  _AgendarCitaPageState createState() => _AgendarCitaPageState();
}

class _AgendarCitaPageState extends State<AgendarCitaPage> {
  String? nombreUsuario;
  String _asunto = '';

  @override
  void initState() {
    super.initState();
    // Obtener el usuario actualmente autenticado
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Si el usuario está autenticado, obtener su ID
      String userId = user.uid;
      // Consultar la colección "USERS" en Firestore
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(userId)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          // Si el documento existe, obtener el nombre y el apellido del usuario
          Map<String, dynamic> userData =
              documentSnapshot.data() as Map<String, dynamic>;
          setState(() {
            // Concatenar el nombre y el apellido del usuario
            nombreUsuario = '${userData['firstName']} ${userData['lastName']}';
          });
        } else {
          // Si el documento no existe, manejar la situación aquí
          print('El documento del usuario no existe en Firestore');
        }
      }).catchError((error) {
        // Manejar cualquier error que ocurra durante la consulta
        print('Error al obtener el documento del usuario: $error');
      });
    } else {
      // Si el usuario no está autenticado, manejar la situación aquí
      print('El usuario no está autenticado');
    }
  }

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _fechaSeleccionada = picked;
      });
    }
  }

  Future<void> _seleccionarHora(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _horaSeleccionada = picked;
      });
    }
  }

  Future<void> _agendarCita() async {
    try {
      final fechaHoraCita = DateTime(
        _fechaSeleccionada.year,
        _fechaSeleccionada.month,
        _fechaSeleccionada.day,
        _horaSeleccionada.hour,
        _horaSeleccionada.minute,
      );
      await FirebaseFirestore.instance.collection('citas').add({
        'nombreAbogado': widget.nombreAbogado,
        'nombreUsuario': nombreUsuario ?? 'Usuario',
        'fechaHoraCita': fechaHoraCita,
        'asunto': _asunto, // Agregar el asunto de la cita
      });
      // Mostrar un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cita agendada correctamente')),
      );
      // Volver atrás
      Navigator.of(context).pop();
    } catch (e) {
      // Error al agregar la cita
      // Puedes mostrar un mensaje de error o realizar cualquier otra acción necesaria.
      print('Error al agregar la cita: $e');
    }
  }

  DateTime _fechaSeleccionada = DateTime.now();
  TimeOfDay _horaSeleccionada = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Agendar Cita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Nombre del usuario:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              nombreUsuario ?? 'Usuario',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Nombre del abogado:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              widget.nombreAbogado,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Asunto de la cita:', // Cambiado a "Asunto de la cita"
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _asunto = value; // Guardar el valor del asunto
                });
              },
              decoration: InputDecoration(
                hintText: 'Ingrese el asunto de la cita',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Fecha de la cita:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _seleccionarFecha(context),
                  child: Text('Seleccionar Fecha'),
                ),
                SizedBox(width: 20),
                Text(
                  '${_fechaSeleccionada.day}/${_fechaSeleccionada.month}/${_fechaSeleccionada.year}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Hora de la cita:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _seleccionarHora(context),
                  child: Text('Seleccionar Hora'),
                ),
                SizedBox(width: 20),
                Text(
                  '${_horaSeleccionada.hour}:${_horaSeleccionada.minute}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 100),
            Center(
              child: GestureDetector(
                onTap: _agendarCita,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Agendar una cita',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward_ios, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
