import 'package:flutter/material.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:knittda/src/domain/use_case/update_work_use_case.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'auth_view_model.dart';

class EditWorkViewModel extends ChangeNotifier {
  final UpdateWorkUseCase _updateWorkUseCase;
  final AuthViewModel _auth;

  final WorkRepository repository;

  EditWorkViewModel({
    required AuthViewModel authViewModel,
    required UpdateWorkUseCase updateWorkUseCase,
    required WorkRepository workRepository
  })  : _auth = authViewModel,
        _updateWorkUseCase = updateWorkUseCase,
        repository = workRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get errorMessage => _error;

  WorkModel? get updatedWork => repository.work;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> updateWork(WorkModel work) async {
    final token = _auth.jwt;
    if (token == null) {
      _error = '로그인이 필요합니다.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    try {
      await _updateWorkUseCase(token, work);
      _error = null;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }
}