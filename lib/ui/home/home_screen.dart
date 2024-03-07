import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawhub/constants.dart';
import 'package:lawhub/models/user.dart';
import 'package:lawhub/services/helper.dart';
import 'package:lawhub/ui/auth/authentication_bloc.dart';
import 'package:lawhub/ui/auth/welcome/welcome_screen.dart';
import 'package:lawhub/ui/abogados/abogados_lista.dart';
import 'package:lawhub/ui/citas/lista_citas.dart';
import 'package:lawhub/ui/auth/profile/profile_screen.dart';
import 'package:provider/provider.dart';
import '../Inicio.dart';
import '../../views/components/bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late User user;

  int _selectedIndex = 0;
  static const List<Widget> _contenidoForm = [
    Inicio(),
    AbogadosLista(),
    ListaCitasAbogados(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.authState == AuthState.unauthenticated) {
          pushAndRemoveUntil(context, const WelcomeScreen(), false);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Text(
                  'LawHub',
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(53, 181, 184, 300),
                ),
              ),
              ListTile(
                title: const Text(
                  'Cerrar Sesión',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Transform.rotate(
                    angle: pi / 1,
                    child: const Icon(Icons.exit_to_app, color: Colors.red)),
                onTap: () {
                  context.read<AuthenticationBloc>().add(LogoutEvent());
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(user.fullName()),
            ),
            user.profilePictureURL == ''
                ? CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey.shade400,
                    child: ClipOval(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          'assets/images/avatar.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : displayCircleImage(user.profilePictureURL, 50, false),
          ],
        ),
        body: Center(
          child: _contenidoForm[_selectedIndex],
        ),
        bottomNavigationBar: GoogleBottomBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
