import 'package:app/model/product.dart';
import 'package:app/screens/add_product_page.dart';
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
                product:snapshot.data![index]
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