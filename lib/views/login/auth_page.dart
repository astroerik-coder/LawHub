import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lawhub/views/home.dart';
import 'package:lawhub/views/login/login_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //usser is logged in
          if (snapshot.hasData) {
            return HomePage();
          }
          //user is not logged in
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
