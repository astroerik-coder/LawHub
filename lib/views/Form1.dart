import 'package:flutter/material.dart';

class Form1 extends StatelessWidget {
  const Form1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 7.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Text("Escuela de las Fuerzas Armadas ESPE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromARGB(255, 27, 6, 222).withOpacity(0.6),
                )),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                const Image(image: AssetImage('assets/images/LawHub.png')),
                const SizedBox(height: 16), 
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Nombre:  ",
                      style:TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text("Erik Molina", style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 16), 
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Curso:  ",
                      style:TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text("Erik Molina", style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 16), 
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Periodo:  ",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text("2023-2024", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
