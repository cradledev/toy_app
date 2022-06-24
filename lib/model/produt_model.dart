class ProductModel {
  int id;
  String name;
  String shortdescription;
  String fulldescription;
  double price;
  double oldPrice;
  String image;
  bool markAsNew;
  String categoryName;
  ProductModel({
    this.id,
    this.name,
    this.shortdescription,
    this.fulldescription,
    this.price,
    this.oldPrice,
    this.image,
    this.markAsNew,
    this.categoryName
  });

  factory ProductModel.fromJson(
      Map<String, dynamic> json, ) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      shortdescription: json['short_description'] ?? "",
      fulldescription: json['full_description'] ?? "",
      price: json['product_price']['price_value'],
      oldPrice : json['product_price']['old_price'],
      image: json['default_picture_model']['image_url'] ?? "",
      markAsNew : json['mark_as_new'],
      categoryName: json['categoryName']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "shortdescription": shortdescription,
      "fulldescription": fulldescription,
      "price": price,
      "image": image,
      "oldPrice": oldPrice,
      "markAsNew": markAsNew,
      "categoryName" : categoryName
    };
  }
}
