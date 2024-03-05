import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lawhub/views/abogados/abogados_lista.dart';
import 'package:lawhub/views/Inicio.dart';
import 'package:lawhub/views/citas/ListaTareasAbogados.dart';
import 'package:lawhub/views/components/bottom_bar.dart';
import 'package:lawhub/views/profile/profile_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _contenidoForm = [
    Inicio(),
    Abogados_Lista(),
    ListaTareasAbogadosFake(),
    ProfileScreen()
  ];

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
          ),
          Text(
            '${user.email}',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      body: Center(
        child: _contenidoForm[_selectedIndex],
      ),
      bottomNavigationBar: GoogleBottomBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
