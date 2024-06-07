class Product {
  final String nombre;
  final String descripcion;
  final double precio;
  final String imagen;
  final int cantidad;
  final double valoracionTotal;

  Product({
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.imagen,
    required this.cantidad,
    required this.valoracionTotal,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'nombre': String nombre,
        'descripcion': String descripcion,
        'precio': double precio,
        'imagen': String imagen,
        'cantidad': int cantidad,
        'valoracion_total': double valoracionTotal,
      } =>
        Product(
          nombre: nombre,
          descripcion: descripcion,
          precio: precio,
          imagen: imagen,
          cantidad: cantidad,
          valoracionTotal: valoracionTotal,
        ),
      _ => throw Exception('Producto invalido'),
    };
  }
}
