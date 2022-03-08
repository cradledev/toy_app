class CustomImage {
  final int id;
  final int pictureid;
  final int position;
  final String src;
  CustomImage({
    required this.id,
    required this.pictureid,
    required this.position,
    required this.src,
  });
  factory CustomImage.fromJson(Map<String, dynamic> json) {
    return CustomImage(
      id: json['id'],
      pictureid: json['picture_id'],
      position: json['position'],
      src: json['src'],
    );
  }
}
