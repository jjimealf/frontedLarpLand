class Product {
  final int id;
  final String nombre;
  final String descripcion;
  final String precio;
  final String imagen;
  final int cantidad;
  final String valoracionTotal;
  final String categoria;

  Product({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.imagen,
    required this.cantidad,
    required this.valoracionTotal,
    required this.categoria,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'nombre': String nombre,
        'descripcion': String descripcion,
        'precio': String precio,
        'imagen': String imagen,
        'cantidad': int cantidad,
        'valoracion_total': String valoracionTotal,
        'categoria': String categoria,
      } =>
        Product(
          id: id,
          nombre: nombre,
          descripcion: descripcion,
          precio: precio,
          imagen: imagen,
          cantidad: cantidad,
          valoracionTotal: valoracionTotal,
          categoria: categoria,
        ),
      _ => throw const FormatException('Fallo al cargar producto'),
    };
  }
}
