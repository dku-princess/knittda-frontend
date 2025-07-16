import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/repositories/record_repository.dart';
import 'package:knittda/src/domain/use_case/record_use_cases.dart';

class RecordViewModel extends ChangeNotifier {
  final RecordUseCases useCases;
  final RecordRepository repository;

  RecordViewModel({
    required this.useCases,
    required this.repository,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get errorMessage => _error;

  RecordModel? get record => repository.record;

  List<RecordModel>? get records => repository.records;

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  Future<bool> getRecord(int recordId) async {
    _setLoading(true);
    try {
      await useCases.getRecord(recordId);
      _error   = null;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> getRecords(int projectId) async {
    _setLoading(true);
    try {
      await useCases.getRecords(projectId);
      _error   = null;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteRecord(int recordId) async {
    _setLoading(true);
    try {
      await useCases.deleteRecord(recordId);
      _error   = null;

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }
}