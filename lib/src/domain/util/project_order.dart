import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_order.freezed.dart';

@freezed
sealed class ProjectOrder with _$ProjectOrder {
  const factory ProjectOrder.inProgress() = InProgress;
  const factory ProjectOrder.done() = Done;
}
