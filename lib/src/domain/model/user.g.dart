// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: (json['id'] as num).toInt(),
  kakaoId: (json['kakaoId'] as num?)?.toInt(),
  appleId: json['appleId'] as String?,
  email: json['email'] as String?,
  nickname: json['nickname'] as String?,
  profileImageUrl: json['profileImageUrl'] as String?,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'kakaoId': instance.kakaoId,
  'appleId': instance.appleId,
  'email': instance.email,
  'nickname': instance.nickname,
  'profileImageUrl': instance.profileImageUrl,
};
