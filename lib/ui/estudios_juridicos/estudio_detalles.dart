import 'package:flutter/material.dart';
import 'model.dart';

class EstudioJuridicoDetails extends StatelessWidget {
  final EstudioJuridico estudioJuridico;

  EstudioJuridicoDetails(this.estudioJuridico);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 5,
                  width: 60,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: Image.asset(estudioJuridico.logoUrl),
                      ),
                      SizedBox(width: 20),
                      Text(
                        estudioJuridico.nombreEstudio,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.bookmark_border_outlined, size: 30),
                      SizedBox(width: 10),
                      Icon(Icons.more_horiz_outlined, size: 30),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                estudioJuridico.cargo,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 25, color: Colors.yellow),
                    SizedBox(width: 10),
                    Text(estudioJuridico.ubicacion),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(Icons.timer, size: 25, color: Colors.yellow),
                      SizedBox(width: 10),
                      Text('Tiempo completo'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Requisitos',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            ...estudioJuridico.requisitos
                .map(
                  (requisito) => Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 0),
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 20),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth: 250),
                            child: Text(
                              requisito,
                              style: TextStyle(wordSpacing: 2, height: 1.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 25),
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica para aplicar ahora
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0, backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text('Aplicar ahora'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
