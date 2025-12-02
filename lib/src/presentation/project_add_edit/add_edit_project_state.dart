import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_edit_project_state.freezed.dart';

@freezed
abstract class AddEditProjectState with _$AddEditProjectState {
  factory AddEditProjectState({required bool isLoading}) = _AddEditProjectState;
}
