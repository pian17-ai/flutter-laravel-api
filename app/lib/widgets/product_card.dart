import 'package:app/model/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onDetail;

  const ProductCard({
    super.key, 
    required this.product, 
    required this.onEdit,
    required this.onDelete,
    required this.onDetail
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onDetail,
    child: Card(
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

          const SizedBox(height: 10,),

          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white
                  ),
                  onPressed: onEdit,
                  icon: Icon(Icons.update),
                  label: const Text("Edit"),
                )
                ),

                const SizedBox(height: 10,),

                Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white
                  ),
                  onPressed: onDelete,
                  icon: Icon(Icons.delete),
                  label: const Text("Delete"),
                )
                ),
            ],
          )
        ],
      ),
      ),
    )
    );
  }
}