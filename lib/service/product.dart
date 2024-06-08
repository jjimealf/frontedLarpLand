import 'dart:convert';
import 'dart:io';

import 'package:larpland/model/product.dart';
import 'package:http/http.dart' as http;

Future<Product> addProduct(String name, String descripcion, String precio,
    int stock, String categoria, File imagen) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8000/api/products'),
    body: {
      'nombre': name,
      'descripcion': descripcion,
      'precio': precio,
      'stock': stock.toString(),
      'categoria': categoria,
      'imagen': imagen.toString(),
    },
  );
  if (response.statusCode == 201) {
    return Product.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Fallo al agregar producto');
  }
}
