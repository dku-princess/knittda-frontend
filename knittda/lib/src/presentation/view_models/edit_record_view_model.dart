import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/repositories/record_repository.dart';
import 'package:knittda/src/domain/use_case/record_use_cases.dart';
import 'package:knittda/src/domain/use_case/update_record_use_case.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';

class EditRecordViewModel extends ChangeNotifier {
  final RecordUseCases useCases;
  final RecordRepository repository;

  EditRecordViewModel({
    required this.useCases,
    required this.repository,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get errorMessage => _error;

  RecordModel? get updatedRecord => repository.record;

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  Future<bool> updateRecord(RecordModel record, List<int>? deleteImageIds) async {
    _setLoading(true);
    try {
      await useCases.updateRecord(record, deleteImageIds);
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