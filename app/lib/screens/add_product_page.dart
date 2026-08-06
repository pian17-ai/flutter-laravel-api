import 'package:app/model/product.dart';
import 'package:app/services/api_service.dart';
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey=GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final descriptionController = TextEditingController();
  final ApiService api = ApiService();

  bool loading = false;

  Future<void>saveData()async{
    if(!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      loading = true;
    });
    Product product = Product(
      name: nameController.text, 
      price: double.parse(priceController.text), 
      stock: int.parse(stockController.text), 
      description: descriptionController.text);

      bool success = await api.storeProduct(product);
      setState(() {
        loading = false;
      });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Successfully Added Product"))
        );

        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed Added Product")));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"), centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Product Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.shopping_bag)
                ),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Product Name is required";
                  } return null;
                },
              ),

              const SizedBox(height: 20,),

              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: "Product Price",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.price_change)
                ),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Product Price is required";
                  } return null;
                },
              ),

              const SizedBox(height: 20,),

              TextFormField(
                controller: stockController,
                decoration: const InputDecoration(
                  labelText: "Product Stock",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.inventory)
                ),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Product Stock is required";
                  } return null;
                },
              ),

              const SizedBox(height: 20,),

              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Product Description",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description)
                ),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Product Description is required";
                  } return null;
                },
              ),

              const SizedBox(height: 20,),

              SizedBox(
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: loading?null:saveData, 
                  icon: loading ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.pinkAccent,
                    ),
                  ) : const Icon(Icons.save),
                  label: Text(loading ? "Saving" : "Save"),
                  ),
              )

            ],
            ),
      ),),
    );
  }
}