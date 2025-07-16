import 'package:flutter/material.dart';
import 'package:knittda/src/domain/use_case/work_use_cases.dart';
import 'package:knittda/src/data/models/work_model.dart';

class WorkViewModel extends ChangeNotifier {
  final WorkUseCases useCases;

  WorkViewModel(this.useCases,);

  bool _isLoading = false;
  String? _error;
  WorkModel? _work;
  List<WorkModel> _works = [];

  bool get isLoading => _isLoading;

  String? get error => _error;

  WorkModel? get work => _work;

  List<WorkModel> get works => List.unmodifiable(_works);

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> getWork(int projectId) async {
    _setLoading(true);
    try {
      _work = await useCases.getWork(projectId);
      _error = null;
      notifyListeners();
      return true;
    } catch (_) {
      _error = "작품을 불러오는데 실패했습니다.";
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> getWorks() async {
    _setLoading(true);
    try {
      _works = await useCases.getWorks();
      _error = null;
      notifyListeners();
      return true;
    } catch (_) {
      _error = "작품 목록을 불러오는데 실패했습니다.";
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> createWork(WorkModel work) async {
    _setLoading(true);
    try {
      final created = await useCases.createWork(work);
      _works.add(created);
      _work = created;
      _error = null;
      notifyListeners();
      return true;
    } catch (_) {
      _error = "작품 생성에 실패했습니다.";
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteWork(int projectId) async {
    _setLoading(true);
    try {
      await useCases.deleteWork(projectId);
      _works.removeWhere((w) => w.id == projectId);
      if (_work?.id == projectId) {
        _work = null;
      }
      _error = null;
      notifyListeners();
      return true;
    } catch (_) {
      _error = "작품 삭제에 실패했습니다.";
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateWork(WorkModel work) async {
    _setLoading(true);
    try {
      final updated = await useCases.updateWork(work);

      final index = _works.indexWhere((w) => w.id == updated.id);
      if (index != -1) {
        _works[index] = updated;
      } else {
        _works.add(updated);
      }

      _work = updated;
      _error = null;
      notifyListeners();
      return true;
    } catch (_) {
      _error = "작품 수정에 실패했습니다.";
      return false;
    } finally {
      _setLoading(false);
    }
  }
}