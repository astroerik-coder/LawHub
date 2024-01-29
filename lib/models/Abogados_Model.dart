import 'dart:convert';

class Abogado {
  String nombre;
  String especializacion;
  Ubicacion ubicacion;
  Contacto contacto;
  List<EducacionCertificacione> educacionCertificaciones;
  TarifasHonorarios tarifasHonorarios;
  Disponibilidad disponibilidad;
  FirmaLegal firmaLegal;
  List<String> mediosPago;
  List<String>? fotosPerfil;
  InformacionLegal? informacionLegal;
  String? politicaCancelacionReembolso;

  Abogado({
    required this.nombre,
    required this.especializacion,
    required this.ubicacion,
    required this.contacto,
    required this.educacionCertificaciones,
    required this.tarifasHonorarios,
    required this.disponibilidad,
    required this.firmaLegal,
    required this.mediosPago,
    this.fotosPerfil,
    this.informacionLegal,
    this.politicaCancelacionReembolso,
  });

  factory Abogado.fromJson(Map<String, dynamic> json) => Abogado(
        nombre: json['nombre'],
        especializacion: json['especializacion'],
        ubicacion: Ubicacion.fromJson(json['ubicacion']),
        contacto: Contacto.fromJson(json['contacto']),
        educacionCertificaciones: List<EducacionCertificacione>.from(
            json['educacion_certificaciones']
                .map((x) => EducacionCertificacione.fromJson(x))),
        tarifasHonorarios:
            TarifasHonorarios.fromJson(json['tarifas_honorarios']),
        disponibilidad: Disponibilidad.fromJson(json['disponibilidad']),
        firmaLegal: FirmaLegal.fromJson(json['firma_legal']),
        mediosPago: List<String>.from(json['medios_pago']),
        fotosPerfil: json['fotos_perfil'] != null
            ? List<String>.from(json['fotos_perfil'])
            : null,
        informacionLegal: json['informacion_legal'] != null
            ? InformacionLegal.fromJson(json['informacion_legal'])
            : null,
        politicaCancelacionReembolso: json['politica_cancelacion_reembolso'],
      );

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'especializacion': especializacion,
        'ubicacion': ubicacion.toJson(),
        'contacto': contacto.toJson(),
        'educacion_certificaciones':
            List<dynamic>.from(educacionCertificaciones.map((x) => x.toJson())),
        'tarifas_honorarios': tarifasHonorarios.toJson(),
        'disponibilidad': disponibilidad.toJson(),
        'firma_legal': firmaLegal.toJson(),
        'medios_pago': List<dynamic>.from(mediosPago.map((x) => x)),
        'fotos_perfil': fotosPerfil != null
            ? List<dynamic>.from(fotosPerfil!.map((x) => x))
            : null,
        'informacion_legal':
            informacionLegal != null ? informacionLegal!.toJson() : null,
        'politica_cancelacion_reembolso': politicaCancelacionReembolso,
      };
}

class Ubicacion {
  String ciudad;
  String pais;
  String direccion;

  Ubicacion({
    required this.ciudad,
    required this.pais,
    required this.direccion,
  });

  factory Ubicacion.fromJson(Map<String, dynamic> json) => Ubicacion(
        ciudad: json['ciudad'],
        pais: json['pais'],
        direccion: json['direccion'],
      );

  Map<String, dynamic> toJson() => {
        'ciudad': ciudad,
        'pais': pais,
        'direccion': direccion,
      };
}

class Contacto {
  String telefono;
  String correo;

  Contacto({
    required this.telefono,
    required this.correo,
  });

  factory Contacto.fromJson(Map<String, dynamic> json) => Contacto(
        telefono: json['telefono'],
        correo: json['correo'],
      );

  Map<String, dynamic> toJson() => {
        'telefono': telefono,
        'correo': correo,
      };
}

class Disponibilidad {
  List<String> dias;
  String horario;

  Disponibilidad({
    required this.dias,
    required this.horario,
  });

  factory Disponibilidad.fromJson(Map<String, dynamic> json) => Disponibilidad(
        dias: List<String>.from(json['dias']),
        horario: json['horario'],
      );

  Map<String, dynamic> toJson() => {
        'dias': List<dynamic>.from(dias.map((x) => x)),
        'horario': horario,
      };
}

class EducacionCertificacione {
  String? titulo;
  String institucion;
  int anoObtencion;
  String? certificacion;

  EducacionCertificacione({
    this.titulo,
    required this.institucion,
    required this.anoObtencion,
    this.certificacion,
  });

  factory EducacionCertificacione.fromJson(Map<String, dynamic> json) =>
      EducacionCertificacione(
        titulo: json['titulo'],
        institucion: json['institucion'],
        anoObtencion: json['ano_obtencion'],
        certificacion: json['certificacion'],
      );

  Map<String, dynamic> toJson() => {
        'titulo': titulo,
        'institucion': institucion,
        'ano_obtencion': anoObtencion,
        'certificacion': certificacion,
      };
}

class FirmaLegal {
  String nombre;
  String descripcion;

  FirmaLegal({
    required this.nombre,
    required this.descripcion,
  });

  factory FirmaLegal.fromJson(Map<String, dynamic> json) => FirmaLegal(
        nombre: json['nombre'],
        descripcion: json['descripcion'],
      );

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'descripcion': descripcion,
      };
}

class InformacionLegal {
  String numeroColegiado;
  String licenciaEjercicio;

  InformacionLegal({
    required this.numeroColegiado,
    required this.licenciaEjercicio,
  });

  factory InformacionLegal.fromJson(Map<String, dynamic> json) =>
      InformacionLegal(
        numeroColegiado: json['numero_colegiado'],
        licenciaEjercicio: json['licencia_ejercicio'],
      );

  Map<String, dynamic> toJson() => {
        'numero_colegiado': numeroColegiado,
        'licencia_ejercicio': licenciaEjercicio,
      };
}

class TarifasHonorarios {
  String tipo;
  String monto;

  TarifasHonorarios({
    required this.tipo,
    required this.monto,
  });

  factory TarifasHonorarios.fromJson(Map<String, dynamic> json) =>
      TarifasHonorarios(
        tipo: json['tipo'],
        monto: json['monto'],
      );

  Map<String, dynamic> toJson() => {
        'tipo': tipo,
        'monto': monto,
      };
}
