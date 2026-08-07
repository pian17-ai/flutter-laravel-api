import 'package:app/model/product.dart';
import 'package:app/services/api_service.dart';
import 'package:flutter/material.dart';

class UpdateProductPage extends StatefulWidget {
  final Product product;
  const UpdateProductPage({super.key, required this.product});

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final _formKey=GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final descriptionController = TextEditingController();
  final ApiService api = ApiService();
  bool loading = false;

  @override
  void initState() {
    super.initState();

    print("UPDATE PAGE ID = ${widget.product.id}");

    nameController.text = widget.product.name;
    priceController.text = widget.product.price.toString();
    stockController.text = widget.product.stock.toString();
    descriptionController.text = widget.product.description;
  }

  Future<void>updateData() async {
    if(!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      loading = true;
    });
    Product product = Product(
      id: widget.product.id,
      name: nameController.text, 
      price: double.parse(priceController.text), 
      stock: int.parse(stockController.text), 
      description: descriptionController.text);

      bool success = await api.updateProduct(product);
      setState(() {
        loading = false;
      });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Successfully Updated Product"))
        );

        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed Updated Product")));
      }
  }

  Future<void>updateConfirm() async {
    bool ? result = await showDialog(
      context: context, 
      builder: (_) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are u sure for update this Product?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              }, 
              child: const Text("Cancel")
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                }, 
                child: const Text("Sure")
              )
          ],
        );
      }
    );

    if (result == true) {
      updateData();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Product"), centerTitle: true,
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
                  onPressed: loading?null:updateConfirm, 
                  icon: loading ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.pinkAccent,
                    ),
                  ) : const Icon(Icons.update),
                  label: Text(loading ? "Updating..." : "Updated!"),
                  ),
              )

            ],
            ),
      ),),
    );
  }
}