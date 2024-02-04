import 'package:flutter/material.dart';
import 'package:lawhub/models/Abogados_Model.dart';
import 'package:lawhub/services/Abogados_Services.dart';
import 'Form2.dart';

class Form1 extends StatefulWidget {
  const Form1({super.key});

  @override
  State<Form1> createState() => _Form1State();
}

class _Form1State extends State<Form1> {
  final AbogadosService _abogadosService = AbogadosService();
  List<Abogado>? _apiDataList;

  @override
  void initState() {
    super.initState();
    loadApiData();
  }

  Future<void> loadApiData() async {
    try {
      List<Abogado>? apiData = await _abogadosService.getAbogado();

      if (apiData != null) {
        setState(() {
          _apiDataList = apiData;
        });
      }
    } catch (error) {
      print('Error al cargar datos de la API: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            verticalDirection: VerticalDirection.down,
            children: [
/*               barraBusqueda(), */
              miCard(),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 20),
                child: const Text(
                  "Mejores abogados",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              destinations(),
              Form2(),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }

  Container miCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Parte izquierda con título y botón
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Título de la Card',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Botón'),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Image.network(
                  'https://images.unsplash.com/photo-1491336477066-31156b5e4f35?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container destinations() {
    return Container(
      alignment: Alignment.bottomLeft,
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      height: 350,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _apiDataList?.length ?? 0,
        itemBuilder: (context, index) {
          Abogado? abogado = _apiDataList?[index];

          return InkWell(
            onTap: () {
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: Card(
                shadowColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: DecoratedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        verticalDirection: VerticalDirection.down,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 90, bottom: 10),
                            child: Text(
                              abogado?.nombre ?? 'Sin nombre',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  child: const Icon(
                                    Icons.place,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 100),
                                  child: Text(
                                    abogado?.ubicacion.ciudad ??
                                        'Sin información',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    right: 5,
                                  ),
                                  child: const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    abogado?.disponibilidad.toString() ?? 'S/C',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      position: DecorationPosition.background,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            abogado?.fotosPerfil?.first ??
                                "assets/images/LawHub.png",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
