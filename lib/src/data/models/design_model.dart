class DesignModel {
  final int id;
  final String? title;
  final String? designer;
  final String? needleInfo;
  final String? yarnInfo;
  final String? description;
  final DateTime? createdAt;
  //final String? price;
  //final String? imageUrl;
  //final String? detailUrl;
  // String? categories;
  //final String? tools;
  //final String? sizes;
  //final String? gauge;

  DesignModel({
    required this.id,
    this.title,
    this.designer,
    this.needleInfo,
    this.yarnInfo,
    this.description,
    this.createdAt
    //this.price,
    //this.imageUrl,
    //this.detailUrl,
    //this.categories,
    //this.tools,
    //this.sizes,
    //this.gauge,
    //this.pages,
  });

  factory DesignModel.fromJson(Map<String, dynamic> json) {
    return DesignModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String ?,
      designer: json['designer'] as String?,
      needleInfo: json['needleInfo'] as String ?,
      yarnInfo: json['yarnInfo'] as String?,
      description: json['description'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      //price: json['price'] as String?,
      //imageUrl: json['imageUrl'] as String ?,
      //detailUrl: json['detailUrl'] as String?,
      //categories: json['categories'] as String?,
      //tools: json['tools'] as String ?,
      //sizes: json['sizes'] as String?,
      //gauge: json['gauge'] as String?,
      //pages: json['pages'] as String?,
    );
  }
}