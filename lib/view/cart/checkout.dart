import 'package:flutter/material.dart';
import 'package:larpland/provider/cart_provider.dart';
import 'package:provider/provider.dart';


class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(cartItems[index].nombre),
                    subtitle: Text(
                        'Cantidad: ${cartItems[index].cantidadCarrito} \nTotal: \$${double.parse(cartItems[index].precio) * cartItems[index].cantidadCarrito}'),
                  );
                },
              ),
            ),
            Text(
              'Total: \$${cart.totalAmount}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Process the order
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Pedido Realizado'),
                      content: const Text('Gracias por su compra!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            cart.clearCart();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('realizar pedido'),
            ),
          ],
        ),
      ),
    );
  }
}
