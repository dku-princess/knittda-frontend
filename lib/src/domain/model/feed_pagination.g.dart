// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedPagination _$FeedPaginationFromJson(Map<String, dynamic> json) =>
    _FeedPagination(
      totalElements: (json['totalElements'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      content: (json['content'] as List<dynamic>)
          .map((e) => Feed.fromJson(e as Map<String, dynamic>))
          .toList(),
      number: (json['number'] as num).toInt(),
      first: json['first'] as bool? ?? false,
      last: json['last'] as bool? ?? false,
      empty: json['empty'] as bool? ?? false,
      searchId: json['searchId'] as String?,
      searchVersion: json['searchVersion'] as String?,
    );

Map<String, dynamic> _$FeedPaginationToJson(_FeedPagination instance) =>
    <String, dynamic>{
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'size': instance.size,
      'content': instance.content,
      'number': instance.number,
      'first': instance.first,
      'last': instance.last,
      'empty': instance.empty,
      'searchId': instance.searchId,
      'searchVersion': instance.searchVersion,
    };
