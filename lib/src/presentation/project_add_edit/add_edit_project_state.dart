import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/default_thumbnail.dart';

part 'add_edit_project_state.freezed.dart';

@freezed
abstract class AddEditProjectState with _$AddEditProjectState {
  factory AddEditProjectState({
    required bool isLoading,
    @Default([]) List<DefaultThumbnail> defaultThumbnails,
  }) = _AddEditProjectState;
}
