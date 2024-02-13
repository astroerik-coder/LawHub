import 'package:flutter/material.dart';
import './model.dart';

class EstudioJuridicoItem extends StatelessWidget {
  final EstudioJuridico estudioJuridico;

  EstudioJuridicoItem(this.estudioJuridico);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(estudioJuridico.logoUrl),
                  ),
                  SizedBox(width: 20),
                  Text(
                    estudioJuridico.nombreEstudio.length > 20 ? 
                      estudioJuridico.nombreEstudio.substring(0, 20) + '...' :
                      estudioJuridico.nombreEstudio,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.bookmark_border_outlined,
                color: Colors.grey,
                size: 30,
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            estudioJuridico.cargo,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.yellow,
                size: 32,
              ),
              SizedBox(width: 10),
              Text(
                estudioJuridico.ubicacion,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
