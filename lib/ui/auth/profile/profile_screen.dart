import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lawhub/ui/auth/profile/components/customshape.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? usuario = FirebaseAuth.instance.currentUser;
    String? uid = usuario?.uid;

    return StreamBuilder<DocumentSnapshot>(
      stream:
          FirebaseFirestore.instance.collection('USERS').doc(uid).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        Map<String, dynamic> datosUsuario =
            snapshot.data!.data() as Map<String, dynamic>;
        String nombreUsuario = datosUsuario['firstName'];
        String apellidoUsuario = datosUsuario['lastName'];
        String correoElectronicoUsuario = datosUsuario['email'];
        String? urlImagenPerfil = datosUsuario['profilePictureURL'];

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.blue,
          ),
          body: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  painter: HeaderCurvedContainer(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Perfil',
                        style: TextStyle(
                          fontSize: 35.0,
                          letterSpacing: 1.5,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 2,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade400,
                      ),
                      child: ClipOval(
                        child: urlImagenPerfil != null &&
                                urlImagenPerfil.isNotEmpty
                            ? Image.network(
                                urlImagenPerfil,
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              )
                            : Image.asset(
                                'assets/images/avatar.png',
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$nombreUsuario $apellidoUsuario',
                      style: const TextStyle(
                          fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text("Correo Electrónico"),
                      subtitle: Text(correoElectronicoUsuario),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
