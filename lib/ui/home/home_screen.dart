import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawhub/constants.dart';
import 'package:lawhub/models/user.dart';
import 'package:lawhub/services/helper.dart';
import 'package:lawhub/ui/auth/authentication_bloc.dart';
import 'package:lawhub/ui/auth/welcome/welcome_screen.dart';
import 'package:lawhub/views/abogados/abogados_lista.dart';
import 'package:lawhub/views/citas/ListaTareasAbogados.dart';
import 'package:lawhub/views/profile/profile_screen.dart';
import 'package:provider/provider.dart';

import '../../views/Inicio.dart';
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
    Abogados_Lista(),
    ListaTareasAbogadosFake(),
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
                  color: Color(COLOR_PRIMARY),
                ),
              ),
              ListTile(
                title: const Text(
                  'Cerrar Sesión',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Transform.rotate(
                    angle: pi / 1,
                    child: const Icon(Icons.exit_to_app, color: Colors.black)),
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
              padding: const EdgeInsets.all(8.0),
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
                : displayCircleImage(user.profilePictureURL, 80, false),
          ],
        ),
        body: Center(
          child: _contenidoForm[_selectedIndex],
        ),
        bottomNavigationBar: GoogleBottomBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        /* child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              user.profilePictureURL == ''
                  ? CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey.shade400,
                      child: ClipOval(
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: Image.asset(
                            'assets/images/placeholder.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : displayCircleImage(user.profilePictureURL, 80, false),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(user.fullName()),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(user.email),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(user.userID),
              ),
            ],
          ), 
        ),*/
      ),
    );
  }
}
