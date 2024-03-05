import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawhub/constants.dart';
import 'package:lawhub/services/helper.dart';
import 'package:lawhub/ui/auth/authentication_bloc.dart';
import 'package:lawhub/ui/auth/welcome/welcome_screen.dart';
/* import 'package:lawhub/ui/home/home_screen.dart';*/import 'package:lawhub/views/home.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({Key? key}) : super(key: key);

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthenticationBloc>().add(CheckFirstRunEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(COLOR_PRIMARY),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          switch (state.authState) {
            case AuthState.authenticated:
                /*pushReplacement(context, HomeScreen(user: state.user!));*/             
                pushReplacement(context, HomePage());
                break;
            case AuthState.unauthenticated:
              pushReplacement(context, const WelcomeScreen());
              break;
            case AuthState.firstRun:
              // TODO: Handle this case.
          }
        },
        child: const Center(
          child: CircularProgressIndicator.adaptive(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation(Color(COLOR_PRIMARY)),
          ),
        ),
      ),
    );
  }
}
