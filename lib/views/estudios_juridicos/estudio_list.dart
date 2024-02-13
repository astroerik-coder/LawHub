import 'package:flutter/material.dart';
import './model.dart';
import './estudio_detalles.dart';
import './estudio_item.dart';

class EstudioJuridicoList extends StatelessWidget {
  final List<EstudioJuridico> estudiosJuridicos = EstudioJuridico.generarListaEstudios();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      height: 200,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 30),
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) => EstudioJuridicoDetails(estudiosJuridicos[index]),
              );
            },
            child: EstudioJuridicoItem(estudiosJuridicos[index]),
          );
        },
        separatorBuilder: (_, index) => SizedBox(width: 15),
        itemCount: estudiosJuridicos.length,
      ),
    );
  }
}
