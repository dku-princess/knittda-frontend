import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/domain/use_case/record_use_cases.dart';

class RecordListViewModel extends ChangeNotifier {
  final RecordUseCases useCases;

  RecordListViewModel(
    this.useCases,
  );

  bool _isLoading = false;
  String? _error;
  final List<RecordModel> _records = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<RecordModel> get records => List.unmodifiable(_records);

  Future<void> refresh(int projectId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final fetched = await useCases.getRecords(projectId);
      _records
        ..clear()
        ..addAll(fetched);
    } catch (e) {
      _error = "기록 목록을 불러오는데 실패했습니다.";

    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<bool> remove(int recordId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await useCases.deleteRecord(recordId);
      _records.removeWhere((r) => r.id == recordId);
      return true;
    } catch (e) {
      _error = "기록 삭제에 실패했습니다.";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void insertOrReplace(RecordModel record) {
    final index = _records.indexWhere((r) => r.id == record.id);
    if (index == -1) {
      _records.insert(0, record);
    } else {
      _records[index] = record;
    }
    notifyListeners();
  }

}