class ProductDetailModel {
  int id;
  String name;
  String shortdescription;
  String fulldescription;
  double price;
  double oldPrice;
  String image;
  List pictures;
  bool markAsNew;
  String categoryName;
  int categoryId;
  ProductDetailModel({
    this.id,
    this.name,
    this.shortdescription,
    this.fulldescription,
    this.price,
    this.oldPrice,
    this.image,
    this.pictures,
    this.markAsNew,
    this.categoryName,
    this.categoryId
  });

  factory ProductDetailModel.fromJson(
      Map<String, dynamic> json, ) {
    return ProductDetailModel(
      id: json['id'],
      name: json['name'],
      shortdescription: json['short_description'] ?? "",
      fulldescription: json['full_description'] ?? "",
      price: json['product_price']['price_value'],
      oldPrice : json['product_price']['old_price'],
      image: json['default_picture_model']['image_url'] ?? "",
      markAsNew : json['mark_as_new'],
      pictures: json['picture_models'],
      categoryName: json['breadcrumb']['category_breadcrumb'][0]['name'],
      categoryId: json['breadcrumb']['category_breadcrumb'][0]['id']
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
      "categoryName" : categoryName,
      "pictures" : pictures
    };
  }
}
