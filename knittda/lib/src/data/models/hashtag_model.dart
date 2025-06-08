class HashtagModel {
  final String? hashtag;
  final String? description;

  HashtagModel({
    this.hashtag,
    this.description,
  });

  factory HashtagModel.fromJson(Map<String, dynamic> json) {
    return HashtagModel(
      hashtag: json['hashtag'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

extension HashtagModelJson on HashtagModel {
  Map<String, dynamic> toJson() => {
    'hashtag' : hashtag,
    'description' : description,
  };
}