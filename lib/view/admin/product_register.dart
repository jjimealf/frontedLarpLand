import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:larpland/model/product.dart';
import 'package:larpland/service/product.dart';

class AddProductScreen extends StatefulWidget {

  final Product? product;

  const AddProductScreen({super.key, this.product});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late Future<Product> futureProduct;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  File? image;

@override
  void initState() {
    super.initState();
    if (widget.product != null) {
      nameController.text = widget.product!.nombre;
      descriptionController.text = widget.product!.descripcion;
      priceController.text = widget.product!.precio;
      stockController.text = widget.product!.cantidad.toString();
      categoryController.text = widget.product!.categoria;
      // Assuming you have a way to convert the image URL to a File, if needed
      image = File(widget.product!.imagen);
    }
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() async {
    if (_validateAndSave()) {
      try {
        if (widget.product == null) {
        futureProduct = addProduct(
          nameController.text,
          descriptionController.text,
          priceController.text,
          int.parse(stockController.text),
          categoryController.text,
          image!,
        );
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Producto Agregado'),
            content: const Text('El producto ha sido agregado exitosamente'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddProductScreen(),
                  ),
                ),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        } else {
           updateProduct(
            widget.product!.id,
            name: nameController.text,
            descripcion: descriptionController.text,
            precio: priceController.text,
            stock: stockController.text as int,
            categoria: categoryController.text,
            imagen: image,
          );
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Producto Actualizado'),
              content: const Text('El producto ha sido actualizado exitosamente'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null
            ? 'Agregar Producto'
            : 'Actualizar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingrese el nombre del producto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingrese la descripción del producto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Precio'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingrese el precio del producto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: stockController,
                decoration: const InputDecoration(labelText: 'Stock'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingrese el stock del producto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Categoría'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingrese la categoría del producto';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      image = File(pickedFile.path);
                    });
                  }
                },
                child: const Text('Seleccionar Imagen'),
              ),
              if (image != null) Image.file(image!),
              ElevatedButton(
                onPressed: _validateAndSubmit,
                child: Text(widget.product == null
                    ? 'Agregar Producto'
                    : 'Actualizar Producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
