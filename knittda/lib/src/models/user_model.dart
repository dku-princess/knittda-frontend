class UserModel {
  final int kakaoId;
  final String email;
  final String nickname;
  final String profileImageUrl;

  UserModel({
    required this.kakaoId,
    required this.email,
    required this.nickname,
    required this.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      kakaoId: json['kakaoId'],
      email: json['email'],
      nickname: json['nickname'],
      profileImageUrl: json['profileImageUrl'],
    );
  }
}