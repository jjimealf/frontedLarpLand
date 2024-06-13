import 'package:flutter/material.dart';
import 'package:larpland/view/cart/checkout.dart';
import 'package:provider/provider.dart';
import 'package:larpland/provider/cart_provider.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cartItems[index].nombre),
                  subtitle: Text(
                      'Cantidad: ${cartItems[index].cantidadCarrito} \nTotal: \$${double.parse(cartItems[index].precio) * cartItems[index].cantidadCarrito}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          cart.removeProduct(cartItems[index].id);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          try {
                            cart.addProduct(cartItems[index]);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Total: \$${cart.totalAmount}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (cartItems.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Carrito vacío'),
                        ),
                      );
                      return;
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CheckoutScreen(),
                      ),
                    );
                  },
                  child: const Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
