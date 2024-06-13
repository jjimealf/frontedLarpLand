
class RoleplayEvent {
  final int id;
  final String name;
  final String description;
  final String fechaInicio;
  final String fechaFin;
  bool isRegistered;

  RoleplayEvent({
    required this.id,
    required this.name,
    required this.description,
    required this.fechaInicio,
    required this.fechaFin,
    this.isRegistered = false,
  });

  factory RoleplayEvent.fromJson(Map<String, dynamic> json) {
        return switch (json) {
          {
            'id': int id,
            'nombre': String name,
            'descripcion': String description,
            'fecha_inicio': String fechaInicio,
            'fecha_fin': String fechaFin,
          } =>
            RoleplayEvent(
              id: id,
              name: name,
              description: description,
              fechaInicio: fechaInicio,
              fechaFin: fechaFin,
            ),
          _ => throw const FormatException('Fallo al cargar evento'),

        };     
    }
}
