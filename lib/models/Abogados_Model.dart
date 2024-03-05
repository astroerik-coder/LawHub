class Abogado {
  String ciudad;
  String correo;
  String descripcion;
  String direccion;
  String especializacion;
  String firmaLegal;
  String fotoPerfil;
  String nombre;
  String pais;
  String telefono;

  Abogado({
    required this.ciudad,
    required this.correo,
    required this.descripcion,
    required this.direccion,
    required this.especializacion,
    required this.firmaLegal,
    required this.fotoPerfil,
    required this.nombre,
    required this.pais,
    required this.telefono,
  });

  factory Abogado.fromJson(Map<String, dynamic> json) {
    return Abogado(
      ciudad: json['ciudad'],
      correo: json['correo'],
      descripcion: json['descripcion'],
      direccion: json['direccion'],
      especializacion: json['especializacion'],
      firmaLegal: json['firma_legal'],
      fotoPerfil: json['foto_perfil'],
      nombre: json['nombre'],
      pais: json['pais'],
      telefono: json['telefono'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ciudad': ciudad,
      'correo': correo,
      'descripcion': descripcion,
      'direccion': direccion,
      'especializacion': especializacion,
      'firma_legal': firmaLegal,
      'foto_perfil': fotoPerfil,
      'nombre': nombre,
      'pais': pais,
      'telefono': telefono,
    };
  }
}
