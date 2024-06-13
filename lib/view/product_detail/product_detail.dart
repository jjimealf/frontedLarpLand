
import 'package:flutter/material.dart';
import 'package:larpland/component/review_card.dart';
import 'package:larpland/model/product.dart';
import 'package:larpland/model/user_review.dart';
import 'package:larpland/service/product.dart';
import 'package:larpland/service/user_review.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  final int userId;
  const ProductDetail({super.key, required this.product, required this.userId});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late Future<List<ProductReviews>> futureProductReviews;

  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  int _rating = 1;

  @override
  void initState() {
    super.initState();
    futureProductReviews = fetchProductReviewsById(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.nombre),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://mongoose-hip-lark.ngrok-free.app/storage/img/${widget.product.imagen.split('/').last}",
                  fit: BoxFit.cover,
                  height: 150,
                ),
              ),
              Text(widget.product.nombre),
              Text(widget.product.precio),
              Text(widget.product.valoracionTotal),
              
              const Text(
                "Comentarios y Valoraciones",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              FutureBuilder<List<ProductReviews>>(
                future: futureProductReviews,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ReviewCard(review: snapshot.data![index]);
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
              const Divider(height: 32, thickness: 2),
              const Text(
                "Añade una reseña",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        labelText: 'Comentario',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, introduce un comentario';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    const Text("Valoración"),
                    DropdownButtonFormField<int>(
                      value: _rating,
                      items: List.generate(5, (index) => index + 1)
                          .map((rating) => DropdownMenuItem<int>(
                                value: rating,
                                child: Text('$rating'),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _rating = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _addReview,
                      child: const Text('Enviar reseña'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addReview() {
    if (_formKey.currentState!.validate()) {
      futureProductReviews.then((review) {
        if (review.any((element) => element.userId == widget.userId)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ya has enviado una reseña.')),
          );
        } else {
          _formKey.currentState!.save();
          setState(() {
            try {
              addProductReview(widget.userId, widget.product.id,
                  _commentController.text, _rating);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.toString())),
              );
            }
            _calculateAverageRating();
          });
          _formKey.currentState!.reset();
        }
      });
    }
  }
  
  void _calculateAverageRating() {
    futureProductReviews.then((reviews) {
      if (reviews.isNotEmpty) {
        setState(() {
          updateProduct(widget.product.id, valoracionTotal: (reviews.fold(0, (sum, item) => sum + item.rating) / reviews.length).toString());
        });
      }else{
        return;
      }
    });
  }
}
