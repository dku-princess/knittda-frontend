import 'package:flutter/material.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:knittda/src/domain/use_case/create_work_use_case.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'auth_view_model.dart';

class AddWorkViewModel extends ChangeNotifier {
  final CreateWorkUseCase _createUseCase;
  final AuthViewModel _auth;

  final WorkRepository repository;

  AddWorkViewModel({
    required AuthViewModel authViewModel,
    required CreateWorkUseCase createWorkUseCase,
    required WorkRepository workRepository
  })  : _auth = authViewModel,
        _createUseCase = createWorkUseCase,
        repository = workRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get errorMessage => _error;

  WorkModel? get createdWork => repository.work;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> createWork(WorkModel work) async {
    final token = _auth.jwt;
    if (token == null) {
      _error = '로그인이 필요합니다.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    try {
      await _createUseCase(token, work);
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