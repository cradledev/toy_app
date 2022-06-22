class ProductM {
  int id;
  String name;
  String shortdescription;
  String fulldescription;
  double price;
  int stock;
  List images;
  List detailImages;
  int categoryId;
  String categoryName;
  int approvedratingsum;

  ProductM({
    this.id,
    this.name,
    this.shortdescription,
    this.fulldescription,
    this.price,
    this.stock,
    this.images,
    this.approvedratingsum,
    this.categoryId,
    this.categoryName,
    this.detailImages,
  });

  factory ProductM.fromJson(
      Map<String, dynamic> json, Map<String, dynamic> _tempValues) {
    return ProductM(
      id: json['id'],
      name: json['name'],
      shortdescription: json['short_description'] ?? "",
      fulldescription: json['full_description'] ?? "",
      price: json['price'] ?? 0.0,
      stock: json['stock_quantity'] ?? 0,
      images: _tempValues['images'] ?? [],
      detailImages: _tempValues['detailImages'] ?? [],
      categoryId: _tempValues['category']['id'],
      approvedratingsum: json['approved_rating_sum'] ?? 0,
      categoryName: _tempValues['category']['name']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "shortdescription": shortdescription,
      "fulldescription": fulldescription,
      "price": price,
      "stock": stock,
      "images": images,
      "detailImages": detailImages,
      "categoryId": categoryId,
      "approvedratingsum": approvedratingsum,
      "categoryName": categoryName,
    };
  }
}
