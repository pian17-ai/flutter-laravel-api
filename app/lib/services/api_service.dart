import 'dart:convert';

import 'package:app/model/product.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000/api";
  Future<List<Product>>getProducts() async {
    final response = await http.get(
      Uri.parse("${baseUrl}/products"),
    );
    
    if (response.statusCode == 200) {
      List jsonData=jsonDecode(response.body);
      return jsonData.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Get all data failed");
    }
  }

  Future<bool>storeProduct(
    Product product,
  ) async {
    final response = await http.post(
      Uri.parse("${baseUrl}/products"),
      body: {
        "name" : product.name,
        "price" : product.price.toString(),
        "stock" : product.stock.toString(),
        "description" : product.description,
      }
    );
    return response.statusCode==201;
  }

  Future<bool>updateProduct(Product product) async {
    final response = await http.put(Uri.parse("${baseUrl}/products/${product.id}"),
      body: {
        "name" : product.name,
        "price" : product.price.toString(),
        "stock" : product.stock.toString(),
        "description" : product.description,
      }
    );
    return response.statusCode == 200;
  }

  Future<bool>deleteProduct(Product product) async {
    final response = await http.delete(Uri.parse("${baseUrl}/products/${product.id}"),
    );
    return response.statusCode == 200;
  }
}