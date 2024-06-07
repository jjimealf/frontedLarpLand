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
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    fetchProductList();
  }

  Future<void> fetchProductList() async {
    final response = await http.get(Uri.parse('https://api.example.com/products'));
    if (response.statusCode == 200) {
      setState(() {
        productList = List<Product>.from(jsonDecode(response.body).map((product) => Product.fromJson(product)));
      });
    } else {
      throw Exception('Failed to fetch product list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(productList[index].nombre),
            subtitle: Text(productList[index].cantidad.toString()),
            );
        },
      ),
    );
  }
}