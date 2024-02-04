import 'package:flutter/material.dart';
import '../models/Abogados_Model.dart';

class LawyerDetailPage extends StatelessWidget {
  final Abogado lawyer;

  LawyerDetailPage({required this.lawyer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          children: [
            SizedBox(height: 15),
            Container(
              child: Row(
                children: [
                  Material(
                    elevation: 0.0,
                    child: Container(
                      height: 180,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(lawyer.fotosPerfil![0]),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 30 - 180 - 20,
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text('${lawyer.nombre}', style: TextStyle(fontSize: 30)),
                        Text('Especialización: ${lawyer.especializacion}', style: TextStyle(fontSize: 20, color: Color(0xFF7b8ea3))),
                        Divider(color: Colors.grey),
                        Text('Ubicación: ${lawyer.ubicacion.ciudad}, ${lawyer.ubicacion.pais}', style: TextStyle(fontSize: 16, color: Color(0xFF7b8ea3))),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 40),
            Divider(color: Color(0xFF7b8ea3)),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.favorite, color: Color(0xFF7b8ea3), size: 30),
                      SizedBox(width: 10),
                      Text('Me gusta', style: TextStyle(fontSize: 15)),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.share, color: Color(0xFF7b8ea3), size: 30),
                      SizedBox(width: 10),
                      Text('Compartir', style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Text('Detalles', style: TextStyle(fontSize: 30)),
                Expanded(child: Container()),
              ],
            ),
            SizedBox(height: 30),
            Container(
              height: 200,
              child: Text('Información adicional: ${lawyer.informacionLegal}', style: TextStyle(fontSize: 16, color: Colors.grey)),
            ),
            Divider(color: Color(0xFF7b8ea3)),
            GestureDetector(
              onTap: () {
                /* Navigator.push(context, MaterialPageRoute(builder: (context) => AllBooks())); */
              },
              child: Container(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    Text('Agendar una cita', style: TextStyle(fontSize: 20)),
                    Expanded(child: Container()),
                    IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: null),
                  ],
                ),
              ),
            ),
            Divider(color: Color(0xFF7b8ea3)),
          ],
        ),
      ),
    );
  }
}
