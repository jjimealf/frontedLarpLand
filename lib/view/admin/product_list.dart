import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:larpland/model/product.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Future<List<Product>> productList;

  @override
  void initState() {
    super.initState();
    productList = fetchProductList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: productList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].nombre),
                subtitle: Text(snapshot.data![index].descripcion),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  

  Future<List<Product>> fetchProductList() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/products'));
    if (response.statusCode == 200) {
        return List<Product>.from(jsonDecode(response.body).map((product) => Product.fromJson(product)));
    } else {
      throw Exception('Failed to fetch product list');
    }
  }
}
