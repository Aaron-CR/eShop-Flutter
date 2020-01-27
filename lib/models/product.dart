class Product {
  String amazonURL;
  String brand;
  String deal;
  String description;
  String features;
  String id;
  String photoURL;
  String price;
  String productName;
  String stock;
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

  Product.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        amazonURL = data['amazonURL'],
        brand = data['brand'],
        deal = data['deal'],
        description = data['description'],
        features = data['features'],
        photoURL = data['photoURL'],
        price = data['price'],
        productName = data['productName'],
        stock = data['stock'],
        userId = data['userId'];

  toJson() {
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
