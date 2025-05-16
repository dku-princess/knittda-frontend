import 'package:flutter/material.dart';
import 'package:knittda/src/domain/use_case/create_work_use_case.dart';
import 'package:knittda/src/domain/use_case/delete_work_use_case.dart';
import 'package:knittda/src/domain/use_case/get_work_use_case.dart';
import 'package:knittda/src/domain/use_case/get_works_use_case.dart';
import 'auth_view_model.dart';
import 'package:knittda/src/data/models/work_model.dart';

class WorkViewModel extends ChangeNotifier {
  AuthViewModel _auth;
  final CreateWorkUseCase _createUseCase;
  final DeleteWorkUseCase _deleteUseCase;
  final GetWorkUseCase _getWorkUseCase;
  final GetWorksUseCase _getWorksUseCase;

  WorkViewModel({
    required AuthViewModel authViewModel,
    required CreateWorkUseCase createWorkUseCase,
    required DeleteWorkUseCase deleteWorkUseCase,
    required GetWorkUseCase getWorkUseCase,
    required GetWorksUseCase getWorksUseCase,
  })  : _auth = authViewModel,
        _createUseCase = createWorkUseCase,
        _deleteUseCase = deleteWorkUseCase,
        _getWorkUseCase = getWorkUseCase,
        _getWorksUseCase = getWorksUseCase;

  void update(AuthViewModel auth) {
    _auth = auth;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get errorMessage => _error;

  WorkModel? _created;
  WorkModel? get createdRecord => _created;

  WorkModel? _gotWork;
  WorkModel? get gotWork => _gotWork;

  List<WorkModel>? _gotWorks;
  List<WorkModel>? get gotWorks => _gotWorks;

  void reset({bool all = false}) {
    _created = null;
    _error = null;
    _gotWork = null;
    if (all) {
      _gotWorks = null;
    }
    notifyListeners();
  }

  void _setLoading(bool v) {
    _isLoading = v;
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
      final result = await _createUseCase(token, work);
      _created = result.work;
      _error   = null;

      //목록 갱신
      await getWorks();

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
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
      final result = await _getWorkUseCase(token, projectId);
      _gotWork = result.work;
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
      final result = await _getWorksUseCase(token);
      _gotWorks = result;
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

      // 목록에서 직접 제거
      final index = _gotWorks?.indexWhere((r) => r.id == projectId);
      if (index != null && index != -1) {
        _gotWorks!.removeAt(index);
        notifyListeners();
      }

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }
}