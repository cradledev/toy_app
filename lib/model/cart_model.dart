
class CartModel {
  int id;
  int quantity;
  String unitPrice;
  String subTotal;
  String discount;
  String productName;
  int productId;
  String productImage;
  CartModel({
    this.id,
    this.quantity,
    this.unitPrice,
    this.subTotal,
    this.discount,
    this.productId,
    this.productName,
    this.productImage
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      quantity: json['quantity'],
      unitPrice: json['unit_price'],
      subTotal: json['sub_total'],
      discount: json['discount'],
      productId: json['product_id'],
      productName: json['product_name'],
      productImage: json['picture']['image_url']
    );
  }
}
