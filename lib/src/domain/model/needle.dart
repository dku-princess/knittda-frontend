import 'package:freezed_annotation/freezed_annotation.dart';

part 'needle.freezed.dart';

part 'needle.g.dart';

/// 바늘 종류. 코드는 서버 enum과 같아야 한다(종류를 추가할 때 BE와 함께 수정).
@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum NeedleType {
  knitting('대바늘'),
  crochet('코바늘'),
  tapestry('돗바늘');

  const NeedleType(this.label);

  final String label;
}

/// 바늘 굵기 단위.
@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum NeedleSizeUnit {
  mm('mm'),
  ho('호');

  const NeedleSizeUnit(this.label);

  final String label;
}

/// 종류/단위/굵기는 각각 비어 있을 수 있다.
@freezed
abstract class Needle with _$Needle {
  factory Needle({
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    NeedleType? type,
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    NeedleSizeUnit? unit,
    double? value,
    // 서버가 해석하지 못한 기존 원문. 응답에만 있고 요청에는 보내지 않는다.
    @JsonKey(includeToJson: false) String? rawText,
  }) = _Needle;

  factory Needle.fromJson(Map<String, dynamic> json) => _$NeedleFromJson(json);
}
