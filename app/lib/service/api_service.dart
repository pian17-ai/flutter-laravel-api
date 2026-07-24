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
}