import 'package:flutter/material.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:knittda/src/domain/use_case/delete_work_use_case.dart';
import 'package:knittda/src/domain/use_case/get_work_use_case.dart';
import 'package:knittda/src/domain/use_case/get_works_use_case.dart';
import 'auth_view_model.dart';
import 'package:knittda/src/data/models/work_model.dart';

class WorkViewModel extends ChangeNotifier {
  AuthViewModel _auth;
  final DeleteWorkUseCase _deleteUseCase;
  final GetWorkUseCase _getWorkUseCase;
  final GetWorksUseCase _getWorksUseCase;

  final WorkRepository repository;

  WorkViewModel({
    required AuthViewModel authViewModel,
    required DeleteWorkUseCase deleteWorkUseCase,
    required GetWorkUseCase getWorkUseCase,
    required GetWorksUseCase getWorksUseCase,
    required WorkRepository workRepository
  })  : _auth = authViewModel,
        _deleteUseCase = deleteWorkUseCase,
        _getWorkUseCase = getWorkUseCase,
        _getWorksUseCase = getWorksUseCase,
        repository = workRepository;

  void update(AuthViewModel auth) {
    _auth = auth;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get errorMessage => _error;

  WorkModel? get work => repository.work;

  List<WorkModel>? get works => repository.works;

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  Future<bool> getWork(int projectId) async {
    final token = _auth.jwt;
    if (token == null) {
      _error = '로그인이 필요합니다.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    try {
      await _getWorkUseCase(token, projectId);
      _error   = null;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> getWorks() async {
    final token = _auth.jwt;
    if (token == null) {
      _error = '로그인이 필요합니다.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    try {
      await _getWorksUseCase(token);
      _error   = null;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteWork(int projectId) async {
    final token = _auth.jwt;
    if (token == null) {
      _error = '로그인이 필요합니다.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    try {
      await _deleteUseCase(token, projectId);
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