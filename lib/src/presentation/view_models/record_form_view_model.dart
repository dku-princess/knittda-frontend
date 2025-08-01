import 'package:flutter/foundation.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/domain/use_case/record_use_cases.dart';
import 'package:knittda/src/presentation/view_models/record_detail_view_model.dart';
import 'package:knittda/src/presentation/view_models/record_list_view_model.dart';

class RecordFormViewModel extends ChangeNotifier {
  final RecordUseCases useCases;
  final RecordListViewModel? _listViewModel;
  final RecordDetailViewModel? _detailViewModel;
  final int projectId;

  RecordFormViewModel({
    required this.useCases,
    required this.projectId,
    RecordListViewModel? listViewModel,
    RecordDetailViewModel? detailViewModel,
  }) : _listViewModel = listViewModel,
        _detailViewModel = detailViewModel;

  bool _isSaving = false;
  String? _error;
  String? _prompt;
  bool _isPromptLoading = false;

  bool get isSaving => _isSaving;
  String? get error => _error;
  String? get prompt => _prompt;
  bool get isPromptLoading => _isPromptLoading;

  Future<void> init() async {
    await loadQuestion();
  }

  Future<void> loadQuestion() async {
    _isPromptLoading = true;
    notifyListeners();
    try {
      _prompt = await useCases.getQuestion(projectId);
    } catch (_) {
      _prompt = null; // 실패 시 UI에서 폴백 처리
    } finally {
      _isPromptLoading = false;
      notifyListeners();
    }
  }

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