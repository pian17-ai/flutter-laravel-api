import 'package:app/model/product.dart';
import 'package:app/screens/add_product_page.dart';
import 'package:app/screens/update_product_page.dart';
import 'package:app/services/api_service.dart';
import 'package:app/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService api = ApiService();
  Future<void>deleteProduct(Product product) async {
    bool ? confirm = await showDialog(
      context: context, 
      builder: (_) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are u sure for delete {product.name}?"),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context, false);
            }, child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Sure"))
          ],
        );
      });
      if (confirm == true) {
        bool result = await api.deleteProduct(product);
        if (result) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Deleted product successfully"))
          );

          setState(() {});
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        centerTitle: true,
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            
          });
        },
        child: FutureBuilder<List<Product>>(
        future: api.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if(!snapshot.hasData) {
            return const Center(
              child: Text("Data is empty"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product:snapshot.data![index],
                onEdit: () async {
                  print("LIST PAGE ID = ${snapshot.data![index].id}");
                  final result = await Navigator.push(context, 
                    MaterialPageRoute(builder: (_) => UpdateProductPage(
                      product: snapshot.data![index],
                      )
                    )
                  );

                  if (result == true) {
                    setState(() {
                      
                    });
                  }

                },

                onDelete: () {
                  deleteProduct(snapshot.data![index]);
                },
              );
            },
          );
        },
      ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context, MaterialPageRoute(
              builder: (_) => const AddProductPage()
            ),
          );
          if (result==true) {
            setState(() {
              
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}