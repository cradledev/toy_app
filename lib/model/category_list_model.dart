class CategoryImage {
  final String src;
  final String attachment;
  CategoryImage({
    required this.src,
    required this.attachment,
  });

  factory CategoryImage.fromJson(Map<String, dynamic> json) {
    String attachment = '';
    if (json['attachment'] != null) {
      attachment = json['attachment'];
    }
    String src = '';
    if (json['src'] != null) {
      src = json['src'];
    }
    return CategoryImage(
      src: src,
      attachment: attachment,
    );
  }
}

class CategoryList {
  final int id;
  final String name;
  final String description;
  final CategoryImage image;
  CategoryList({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) {
    CategoryImage temp = CategoryImage(src: "", attachment: "");
    if (json['image'] != null) {
      temp = CategoryImage.fromJson(json['image']);
    }
    String description = "";
    if (json['description'] != null) {
      description = json['description'];
    }
    return CategoryList(
      id: json['id'],
      name: json['name'],
      description: description,
      image: temp,
    );
  }
}
