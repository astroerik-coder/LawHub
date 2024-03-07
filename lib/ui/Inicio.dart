import 'package:flutter/material.dart';
import 'package:lawhub/views/components/searchbar.dart';
import 'package:lawhub/ui/estudios_juridicos/estudio_list.dart';

class Inicio extends StatelessWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Barra(),
              EstudioJuridicoList(),
            ],
          ),
        ],
      ),
    );
  }
}
