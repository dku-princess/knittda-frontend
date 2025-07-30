import 'package:flutter/foundation.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/domain/use_case/record_use_cases.dart';
import 'package:knittda/src/presentation/view_models/record_detail_view_model.dart';
import 'package:knittda/src/presentation/view_models/record_list_view_model.dart';

class RecordFormViewModel extends ChangeNotifier {
  final RecordUseCases useCases;
  final RecordListViewModel? _listViewModel;
  final RecordDetailViewModel? _detailViewModel;

  RecordFormViewModel({
    required this.useCases,
    RecordListViewModel? listViewModel,
    RecordDetailViewModel? detailViewModel,
  }) : _listViewModel = listViewModel,
        _detailViewModel = detailViewModel;

  bool _isSaving = false;
  String? _error;

  bool get isSaving => _isSaving;
  String? get error => _error;

  Future<RecordModel?> save(RecordModel record, {List<int>? deleteImageIds}) async {

    _isSaving = true;
    _error = null;
    notifyListeners();

    try {
      final result = record.id == null
          ? await useCases.createRecord(record)
          : await useCases.updateRecord(record, deleteImageIds);

      _listViewModel?.insertOrReplace(result);

      if (record.id != null) {
        _detailViewModel?.setRecord(result);
      }

      return result;
    } catch (e) {
      _error = '기록 저장에 실패했습니다.';
      return null;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

}