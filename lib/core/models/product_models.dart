class Product {
  String amazonURL;
  String brand;
  bool deal;
  String description;
  String features;
  String id;
  String photoURL;
  double price;
  String productName;
  bool stock;
  String userId;

  Product(
      {this.id,
      this.amazonURL,
      this.brand,
      this.deal,
      this.description,
      this.features,
      this.photoURL,
      this.price,
      this.productName,
      this.stock,
      this.userId});

  static Product fromMap(Map<String, dynamic> map, String id) {
    if (map == null) return null;

    return Product(
      id: id,
      amazonURL: map['amazonURL'],
      brand: map['brand'],
      deal: map['deal'],
      description: map['description'],
      features: map['features'],
      photoURL: map['photoURL'],
      price: map['price'].toDouble(),
      productName: map['productName'],
      stock: map['stock'],
      userId: map['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "amazonURL": amazonURL,
      "brand": brand,
      "deal": deal,
      "description": description,
      "features": features,
      "photoURL": photoURL,
      "price": price,
      "productName": productName,
      "stock": stock,
      "userId": userId,
    };
  }
}
