import 'package:flutter/material.dart';
import '../models/Abogados_Model.dart';
import '../services/Abogados_Services.dart';

class Form1 extends StatefulWidget {
  const Form1({super.key});

  @override
  State<Form1> createState() => _Form1State();
}

class _Form1State extends State<Form1> {
  final AbogadosService _abogadosService = AbogadosService();
  List<Abogado>? _apiDataList;
  List<String> tiposAbogados = ["Civil", "Penal", "Familiar", "Laboral"];

  @override
  void initState() {
    super.initState();
    loadApiData();
  }

  Future<void> loadApiData() async {
    try {
      List<Abogado>? apiData = await _abogadosService.getAbogados();

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              abogados(),
              SizedBox(
                height: 150.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 200.0,
                      child: Card(
                        child: Center(child: Text(tiposAbogados[0])),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 150.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 200.0,
                      child: Card(
                        child: Center(child: Text(tiposAbogados[1])),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container abogados() {
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
            onTap: () {},
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
