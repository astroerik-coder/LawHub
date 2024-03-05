import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import '../../models/Abogados_Model.dart';
import '../../services/Abogados_Services.dart';
import '../LawyerDetailPage.dart';
import 'package:animations/animations.dart';

class Abogados_Lista extends StatefulWidget {
  const Abogados_Lista({Key? key}) : super(key: key);

  @override
  State<Abogados_Lista> createState() => _Abogados_Lista();
}

class _Abogados_Lista extends State<Abogados_Lista> {
  final AbogadosService _abogadosService = AbogadosService();
  List<Abogado>? _lista;
  List<Abogado>? _filteredLista;
  TextEditingController _searchController = TextEditingController();
  final GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  @override
  void initState() {
    super.initState();
    loadAbogados();
  }

  Future<void> loadAbogados() async {
    try {
      List<Abogado> lista = await _abogadosService.getAbogados();
      setState(() {
        _lista = lista;
        _filteredLista = lista;
      });
    } catch (error) {
      print('Error al cargar datos desde Firestore: $error');
    }
  }

  void filterAbogados(String query) {
    setState(() {
      _filteredLista = _lista!.where((abogado) {
        final especializacion = abogado.especializacion ?? '';
        return especializacion.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void searchByType() async {
    String query = _searchController.text.toLowerCase();
    List<Abogado>? filteredAbogados =
        await _abogadosService.getAbogadosByType(query);
    setState(() {
      _filteredLista = filteredAbogados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (_lista != null) {
                return _lista!
                    .map((abogado) => abogado.especializacion ?? '')
                    .where((especializacion) => especializacion
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()))
                    .toSet()
                    .toList();
              } else {
                return [];
              }
            },
            onSelected: (String value) {
              _searchController.text = value;
              searchByType();
            },
            fieldViewBuilder: (BuildContext context,
                TextEditingController controller,
                FocusNode focusNode,
                VoidCallback onFieldSubmitted) {
              return TextField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: 'Buscar por tipo de abogado',
                  suffixIcon: IconButton(
                    onPressed: () {
                      onFieldSubmitted();
                      searchByType();
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
                onChanged: filterAbogados,
              );
            },
          ),
          SizedBox(height: 10),
          Expanded(
            child: _filteredLista == null || _filteredLista!.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: _filteredLista!.length,
                    itemBuilder: (context, index) {
                      Abogado abogado = _filteredLista![index];
                      ContainerTransitionType _transitionType =
                          ContainerTransitionType.fade;

                      return OpenContainer<bool>(
                        transitionType: _transitionType,
                        openBuilder:
                            (BuildContext _, VoidCallback openContainer) {
                          return LawyerDetailPage(abogado: abogado);
                        },
                        closedShape: const RoundedRectangleBorder(),
                        closedElevation: 0.0,
                        closedBuilder:
                            (BuildContext _, VoidCallback openContainer) {
                          return GestureDetector(
                            onTap: openContainer,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Image.network(
                                          abogado.fotoPerfil.isNotEmpty == true
                                              ? abogado.fotoPerfil ?? ''
                                              : '',
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        Container(width: 20),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(height: 5),
                                              Text(
                                                abogado.nombre.toString(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              Container(height: 5),
                                              Text(
                                                abogado.especializacion
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              Container(height: 5),
                                              Text(
                                                abogado.firmaLegal,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              Container(height: 5),
                                              Text(
                                                abogado.correo ?? '',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
 


