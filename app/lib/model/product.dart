class Product {
  int?id;
  String name;
  double price;
  int stock;
  String description;
  String? image;

  Product({
    this.id, 
    required this.name,
    required this.price,
    required this.stock,
    required this.description,
    this.image;
  });

  factory Product.fromJson(Map<String,dynamic>json){
    return Product (
      id: json['id'],
      name: json['name'],
      price: json['price'],
      stock: json['stock'],
      description: json['description']
      gambar: json['image']
    );
  };

  Map<String,dynamic>toJson(){
    return {
      "id": id,
      "name": name,
      "price": price,
      "stock": stock,
      "description": description,
      "image": image,
    }
  }
}