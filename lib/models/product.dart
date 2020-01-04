/* class Product {
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
      {this.amazonURL,
      this.brand,
      this.deal,
      this.description,
      this.features,
      this.id,
      this.photoURL,
      this.price,
      this.productName,
      this.stock,
      this.userId});

  Product.fromMap(Map snapshot, String id)
      : id = id,
        amazonURL = snapshot['amazonURL'] ?? '',
        brand = snapshot['brand'] ?? '',
        deal = snapshot['deal'] ?? '',
        description = snapshot['description'] ?? '',
        features = snapshot['features'] ?? '',
        photoURL = snapshot['photoURL'] ?? '',
        price = snapshot['price'] ?? '',
        productName = snapshot['productName'] ?? '',
        stock = snapshot['stock'] ?? '',
        userId = snapshot['userId'] ?? '';
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
 */

class Product {
  String id;
  String price;
  String productName;
  String photoURL;

  Product({this.id, this.price, this.productName, this.photoURL});

  Product.fromMap(Map snapshot, String id)
      : id = id ?? '',
        price = snapshot['price'] ?? '',
        productName = snapshot['productName'] ?? '',
        photoURL = snapshot['photoURL'] ?? '';

  toJson() {
    return {
      "price": price,
      "productName": productName,
      "photoURL": photoURL,
    };
  }
}
