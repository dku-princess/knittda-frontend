import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/domain/model/records.dart';

part 'add_edit_record_event.freezed.dart';

@freezed
sealed class AddEditRecordEvent with _$AddEditRecordEvent {
  const factory AddEditRecordEvent.saveRecord({
    required Records record,
    List<int>? deleteImageIds,
    required List<XFile>? files,
    // 수정 시 최종 표시 순서 배열(기존: {type:existing,id}, 신규: {type:new,index}).
    List<Map<String, dynamic>>? imageOrder,
  }) = SaveRecord;
}
