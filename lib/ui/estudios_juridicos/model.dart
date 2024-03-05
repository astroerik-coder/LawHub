class EstudioJuridico {
  String logoUrl;
  String nombreEstudio;
  String cargo;
  String ubicacion;
  List<String> requisitos;

  EstudioJuridico(
      this.logoUrl, this.nombreEstudio, this.cargo, this.ubicacion, this.requisitos);

  static List<EstudioJuridico> generarListaEstudios() {
    return [
      EstudioJuridico(
        'assets/images/estudio1_logo.png',
        'Estudio Jurídico Rodríguez y Asociados',
        'Abogado Senior',
        'Latacunga, Ecuador',
        [
          'Experiencia mínima de 5 años en litigios civiles y penales.',
          'Conocimiento profundo del código penal y civil ecuatoriano.',
          'Capacidad para trabajar bajo presión y en equipo.',
          'Dominio del idioma español.'
        ]
      ),
      EstudioJuridico(
        'assets/images/estudio2_logo.png',
        'Bufete Legal García & Gómez',
        'Asistente Legal',
        'Latacunga, Ecuador',
        [
          'Formación académica en Derecho.',
          'Conocimiento de procedimientos judiciales.',
          'Excelentes habilidades de comunicación y redacción.',
          'Disponibilidad para viajar si es necesario.'
        ]
      ),
      EstudioJuridico(
        'assets/images/estudio3_logo.png',
        'Despacho Jurídico Martínez & Pérez',
        'Abogado Corporativo',
        'Latacunga, Ecuador',
        [
          'Experiencia en derecho corporativo y contractual.',
          'Capacidad para negociar y redactar contratos.',
          'Conocimiento de regulaciones laborales y comerciales.',
          'Manejo de software legal y herramientas informáticas.'
        ]
      ),
    ];
  }
}
