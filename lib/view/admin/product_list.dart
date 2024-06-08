import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:larpland/model/product.dart';
import 'package:larpland/view/admin/product_register.dart';

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
    return Stack(
      children: [
        Expanded(
          child: FutureBuilder<List<Product>>(
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
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProductScreen()));
            },
            tooltip: 'Nuevo Producto',
            child: const Icon(Icons.add),
          ),
        )
      ],
    );
  }

  

  Future<List<Product>> fetchProductList() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/products'));
    if (response.statusCode == 200) {
        return List<Product>.from(jsonDecode(response.body).map((product) => Product.fromJson(product)));
    } else {
      throw Exception('Failed to fetch product list');
    }
  }
}
