class ImageModel {
  final int id;
  final String imageUrl;
  final int imageOrder;

  ImageModel({
    required this.id,
    required this.imageUrl,
    required this.imageOrder,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      imageOrder: json['imageOrder'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'imageOrder': imageOrder,
    };
  }
}