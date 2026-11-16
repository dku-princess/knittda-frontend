import 'package:freezed_annotation/freezed_annotation.dart';

part 'yarn.freezed.dart';

part 'yarn.g.dart';

@freezed
abstract class Yarn with _$Yarn {
  factory Yarn({required String name}) = _Yarn;

  factory Yarn.fromJson(Map<String, dynamic> json) => _$YarnFromJson(json);
}
