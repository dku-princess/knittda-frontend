class UserModel {
  final int kakaoId;
  final String? email;
  final String? nickname;
  final String? profileImageUrl;

  UserModel({
    required this.kakaoId,
    required this.email,
    required this.nickname,
    required this.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      kakaoId: json['kakaoId'] as int? ?? 0,
      email: json['email'] as String?,
      nickname: json['nickname'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
    );
  }
}