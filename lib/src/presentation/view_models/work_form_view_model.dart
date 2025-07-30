import 'package:flutter/foundation.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/domain/use_case/work_use_cases.dart';
import 'package:knittda/src/presentation/view_models/work_detail_view_model.dart';
import 'package:knittda/src/presentation/view_models/work_list_view_model.dart';

class WorkFormViewModel extends ChangeNotifier {
  final WorkUseCases useCases;
  final WorkListViewModel? _listViewModel;
  final WorkDetailViewModel? _detailViewModel;

  WorkFormViewModel({
    required this.useCases,
    WorkListViewModel? listViewModel,
    WorkDetailViewModel? detailViewModel,
  }) : _listViewModel = listViewModel,
       _detailViewModel = detailViewModel;

  bool _isSaving = false;
  String? _error;

  bool get isSaving => _isSaving;
  String? get error => _error;

  Future<WorkModel?> save(WorkModel work) async {
    _isSaving = true;
    _error = null;
    notifyListeners();

    try {
      final result = work.id == null
          ? await useCases.createWork(work)
          : await useCases.updateWork(work);

      _listViewModel?.insertOrReplace(result);

      if (work.id != null) {
        _detailViewModel?.setWork(result);
      }

      return result;
    } catch (e) {
      _error = '작품 저장에 실패했습니다.';
      return null;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

}