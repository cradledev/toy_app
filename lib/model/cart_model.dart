import 'package:toy_app/model/product_model.dart';

class CartModel {
  int id;
  int quantity;
  Product product;
  CartModel({
    required this.id,
    required this.quantity,
    required this.product,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    Product _product = Product.fromJson(json['product']);
    return CartModel(
      id: json['id'],
      quantity: json['quantity'],
      product: _product,
    );
  }
}
