
class RoleplayEvent {
  final int id;
  final String name;
  final String description;
  final String image;
  final String fechaInicio;
  final String fechaFin;

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
            'id': int id,
            'nombre': String name,
            'descripcion': String description,
            'image': String image,
            'fecha_inicio': String fechaInicio,
            'fecha_fin': String fechaFin,
          } =>
            RoleplayEvent(
              id: id,
              name: name,
              description: description,
              image: image,
              fechaInicio: fechaInicio,
              fechaFin: fechaFin,
            ),
          _ => throw const FormatException('Fallo al cargar evento'),

        };     
    }
}
