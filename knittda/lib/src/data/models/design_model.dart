class DesignModel {
  final int id;
  final String? title;
  final String? designer;
  final String? price;
  final String? imageUrl;
  final String? detailUrl;
  final String? categories;
  final String? tools;
  final String? sizes;
  final String? gauge;
  final String? needles;
  final String? yarnInfo;
  final String? pages;

  DesignModel({
    required this.id,
    this.title,
    this.designer,
    this.price,
    this. imageUrl,
    this.detailUrl,
    this.categories,
    this.tools,
    this.sizes,
    this.gauge,
    this.needles,
    this.yarnInfo,
    this.pages,
  });

  factory DesignModel.fromJson(Map<String, dynamic> json) {
    return DesignModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String ?,
      designer: json['designer'] as String?,
      price: json['price'] as String?,
      imageUrl: json['imageUrl'] as String ?,
      detailUrl: json['detailUrl'] as String?,
      categories: json['categories'] as String?,
      tools: json['tools'] as String ?,
      sizes: json['sizes'] as String?,
      gauge: json['gauge'] as String?,
      needles: json['needles'] as String ?,
      yarnInfo: json['yarnInfo'] as String?,
      pages: json['pages'] as String?,
    );
  }
}