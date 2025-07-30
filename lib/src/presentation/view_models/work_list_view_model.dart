import 'package:flutter/foundation.dart';
import 'package:knittda/src/domain/use_case/work_use_cases.dart';
import 'package:knittda/src/data/models/work_model.dart';

class WorkListViewModel extends ChangeNotifier {
  final WorkUseCases useCases;

  WorkListViewModel(
    this.useCases,
  );

  bool _isLoading = false;
  String? _error;
  final List<WorkModel> _works = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<WorkModel> get works => List.unmodifiable(_works);

  Future<void> refresh() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final fetched = await useCases.getWorks();
      _works
        ..clear()
        ..addAll(fetched);
    } catch (e) {
      _error = '작품 목록을 불러오는데 실패했습니다.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> remove(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await useCases.deleteWork(id);
      _works.removeWhere((w) => w.id == id);
      return true;
    } catch (e) {
      _error = '작품 삭제에 실패했습니다.';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void insertOrReplace(WorkModel work) {
    final index = _works.indexWhere((w) => w.id == work.id);
    if (index == -1) {
      _works.insert(0, work);
    } else {
      _works[index] = work;
    }
    notifyListeners();
  }

}