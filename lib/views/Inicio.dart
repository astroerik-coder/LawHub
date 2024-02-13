import 'package:flutter/material.dart';
import 'package:lawhub/views/components/home_appbar.dart';
import 'package:lawhub/views/components/searchbar.dart';
import 'package:lawhub/views/estudios_juridicos/estudio_list.dart';


class Inicio extends StatelessWidget {
  const Inicio({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),

              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.grey.withOpacity(0.1)
                ),

              ),
            ],
          ),
          Column(
            children: [
              HomeAppbar(),
              Barra(),
              EstudioJuridicoList(),
            ],
          ),
        ],
      ),
     
    );
  }
}