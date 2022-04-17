class CategoryList {
  final String id;
  final String name;
  final String slug;
  final String image;
  CategoryList({this.id, this.name, this.slug, this.image});

  factory CategoryList.fromJson(Map<String, dynamic> json) {
    return CategoryList(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'] ?? "",
    );
  }
}
