import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/domain/use_case/record_use_cases.dart';

class RecordViewModel extends ChangeNotifier {
  final RecordUseCases useCases;

  RecordViewModel(
    this.useCases,
  );

  bool _isLoading = false;
  String? _error;
  RecordModel? _record;
  List<RecordModel> _records = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  RecordModel? get record => _record;
  List<RecordModel> get records => List.unmodifiable(_records);


  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> getRecord(int recordId) async {
    _setLoading(true);
    try {
      _record = await useCases.getRecord(recordId);
      _error   = null;
      notifyListeners();
      return true;
    } catch (e) {
      _error = "기록을 불러오는데 실패했습니다.";
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> createRecord(RecordModel record) async {
    _setLoading(true);
    try {
      final created = await useCases.createRecord(record);
      _records.add(created);
      _record = created;
      _error   = null;
      notifyListeners();
      return true;
    } catch (e) {
      _error = "기록 생성에 실패했습니다.";
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateRecord(RecordModel record, List<int>? deleteImageIds) async {
    _setLoading(true);
    try {
      final updated = await useCases.updateRecord(record, deleteImageIds);

      final index = _records.indexWhere((w) => w.id == updated.id);
      if (index != -1) {
        _records[index] = updated;
      } else {
        _records.add(updated);
      }

      _record = updated;
      _error   = null;
      notifyListeners();
      return true;
    } catch (e) {
      _error = "기록 수정에 실패했습니다.";
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> getRecords(int projectId) async {
    _setLoading(true);
    try {
      _records = await useCases.getRecords(projectId);
      _error   = null;
      notifyListeners();
      return true;
    } catch (e) {
      _error = "기록 목록을 불러오는데 실패했습니다.";
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteRecord(int recordId) async {
    _setLoading(true);
    try {
      await useCases.deleteRecord(recordId);
      _records.removeWhere((w) => w.id == recordId);
      if (_record?.id == recordId) {
        _record = null;
      }
      _error   = null;
      notifyListeners();
      return true;
    } catch (e) {
      _error = "기록 삭제에 실패했습니다.";
      return false;
    } finally {
      _setLoading(false);
    }
  }
}