import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/repositories/records_repository.dart';
import 'package:knittda/src/domain/use_case/update_record_use_case.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';

class EditRecordViewModel extends ChangeNotifier {
  AuthViewModel _auth;
  final UpdateRecordUseCase _updateRecordUseCase;
  final RecordsRepository repository;

  EditRecordViewModel({
    required AuthViewModel authViewModel,
    required UpdateRecordUseCase updateRecordUseCase,
    required RecordsRepository recordsRepository,
  })  : _auth = authViewModel,
        _updateRecordUseCase = updateRecordUseCase,
        repository = recordsRepository;

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
    final token = _auth.jwt;
    if (token == null) {
      _error = '로그인이 필요합니다.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    try {
      await _updateRecordUseCase(token, record, deleteImageIds);
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