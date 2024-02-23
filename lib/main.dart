import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lawhub/views/Form2.dart';
import 'package:lawhub/views/citas/ListaTareasAbogados.dart';
import 'package:lawhub/views/profile/profile_screen.dart';
import './views/Inicio.dart';
import './views/components/bottom_bar.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:  DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LawHub',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Inicio(),
    Form2(),
    ListaTareasAbogadosFake(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: GoogleBottomBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
