import 'package:app/model/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      child: Padding(padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            product.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal
            ),
          ),

          const SizedBox(height: 10,),

          Text(
            "Price : Rp.${product.price}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal
            ),
          ),

          const SizedBox(height: 10,),

          Text(
            "Price : ${product.stock}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal
            ),
          ),

          const SizedBox(height: 10,),

          Text(
            product.description,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal
            ),
          ),

        ],
      ),
      ),
    );
  }
}