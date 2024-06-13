import 'package:flutter/material.dart';
import 'package:larpland/model/product.dart';
import 'package:larpland/provider/cart_provider.dart';
import 'package:larpland/service/product.dart';
import 'package:larpland/view/cart/cart.dart';
import 'package:larpland/view/product_detail/product_detail.dart';
import 'package:provider/provider.dart';

class CatalogScreen extends StatefulWidget {

  final int userId;

  const CatalogScreen( {super.key, required this.userId});


  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  Future<List<Product>>? products;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    products = fetchProductList();
    searchController.addListener(() {
      filterProducts();
    });
  }

  void filterProducts() {
    if (searchController.text.isNotEmpty) {
      setState(() {
        products = fetchProductList().then((value) => value
            .where((element) => element.nombre
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
            .toList());
      });
    } else {
      setState(() {
        products = fetchProductList();
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Catálogo de Productos'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Buscar producto...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: FutureBuilder<List<Product>>(
                future: products,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetail(
                                  product: snapshot.data![index],
                                  userId: widget.userId,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      "https://mongoose-hip-lark.ngrok-free.app/storage/img/${snapshot.data![index].imagen.split('/').last}",
                                      fit: BoxFit.cover,
                                      height: 150,
                                    )),
                                Text(snapshot.data![index].nombre),
                                Text(snapshot.data![index].precio),
                                ElevatedButton(
                                  onPressed: () {
                                    try {
                                      if (snapshot.data![index].cantidad == 0) {
                                        throw 'Product out of stock';
                                      }
                                      cart.addProduct(snapshot.data![index]);
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(e.toString()),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text('Agregar al carrito'),
                                ),
                              ],
                            ),
                          ),
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
          ],
        ),
      ),
    );
  }
}
