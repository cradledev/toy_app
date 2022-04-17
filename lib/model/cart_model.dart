import 'package:toy_app/model/product.dart';

class CartModel {
  double price;
  int quantity;
  ProductModel product;
  CartModel({
    this.price,
    this.quantity,
    this.product,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    ProductModel _product = ProductModel.fromJson(json['product']);
    double _price = double.parse(json['price'].toString());
    return CartModel(
      price: _price,
      quantity: json['qty'],
      product: _product,
    );
  }
}
