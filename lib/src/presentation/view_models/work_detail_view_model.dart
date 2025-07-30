import 'package:flutter/foundation.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/domain/use_case/work_use_cases.dart';

class WorkDetailViewModel extends ChangeNotifier {
  final WorkUseCases useCases;

  WorkDetailViewModel(
    this.useCases,
  );

  bool _isLoading = false;
  String? _error;
  WorkModel? _work;

  bool get isLoading => _isLoading;
  String? get error => _error;
  WorkModel? get work => _work;

  Future<void> load(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _work = await useCases.getWork(id);
    } catch (e) {
      _error = '작품을 불러오는데 실패했습니다.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setWork(WorkModel newWork) {
    _work = newWork;
    notifyListeners();
  }

}