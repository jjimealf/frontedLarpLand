class RoleplayEvent {
  final String id;
  final String name;
  final String description;
  final String image;
  final DateTime fechaInicio;
  final DateTime fechaFin;

  RoleplayEvent({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.fechaInicio,
    required this.fechaFin,
  });

  factory RoleplayEvent.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'nombre': String name,
        'descripcion': String description,
        'image': String image,
        'fecha_inicio': DateTime fechaInicio,
        'fecha_fin': DateTime fechaFin,
      } =>
        RoleplayEvent(
          id: id,
          name: name,
          description: description,
          image: image,
          fechaInicio: fechaInicio,
          fechaFin: fechaFin,
        ),
      _ => throw const FormatException('Falló al cargar el evento'),
    };
  }
}
