class Manumapping {
  final int productId;
  Manumapping({required this.productId});

  factory Manumapping.fromJson(Map<String, dynamic> json) {
    return Manumapping(
      productId: json['product_id'],
    );
  }
}
