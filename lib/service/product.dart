import 'dart:convert';
import 'dart:io';

import 'package:larpland/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

Future<List<Product>> fetchProductList() async {
  final response =
      await http.get(Uri.parse('https://mongoose-hip-lark.ngrok-free.app/api/products'));
  if (response.statusCode == 200) {
    return List<Product>.from(
        jsonDecode(response.body).map((product) => Product.fromJson(product)));
  } else {
    throw Exception('Fallo al cargar productos');
  }
}

Future<Product> addProduct(String name, String descripcion, String precio,
    int stock, String categoria, File imagen) async {
      var stream = http.ByteStream(DelegatingStream.typed(imagen.openRead()));
  var length = await imagen.length();
  var multipartFile = http.MultipartFile('file', stream, length,
      filename: basename(imagen.path));
  final response = await http.post(
    Uri.parse('https://mongoose-hip-lark.ngrok-free.app/api/products'),
    body: {
      'nombre': name,
      'descripcion': descripcion,
      'precio': precio,
      'cantidad': stock.toString(),
      'categoria': categoria,
      'imagen': multipartFile,
    },
  );
  if (response.statusCode == 200) {
    return Product.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw HttpException('${response.reasonPhrase}');
  }
}

Future<void> updateProduct(int id,
    {String? name,
    String? descripcion,
    String? precio,
    String? valoracionTotal,
    int? stock,
    String? categoria,
    File? imagen}) async {

      Map<String, dynamic> body = {};
      if (name != null) {
        body['nombre'] = name;
      }
      if (descripcion != null) {
        body['descripcion'] = descripcion;
      }
      if (precio != null) {
        body['precio'] = precio;
      }
      if (stock != null) {
        body['cantidad'] = stock.toString();
      }
      if (categoria != null) {
        body['categoria'] = categoria;
      }
      if (imagen != null) {
        body['imagen'] = imagen.toString();
      }
      if (valoracionTotal != null) {
        body['valoracion_total'] = valoracionTotal;
      }


  final response = await http.put(
    Uri.parse('https://mongoose-hip-lark.ngrok-free.app/api/products/$id'),
    body: jsonEncode(body),
  );
  if (response.statusCode != 200) {
    throw Exception('Fallo al actualizar producto');
  }
}
