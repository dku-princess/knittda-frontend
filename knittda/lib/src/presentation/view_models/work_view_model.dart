import 'package:flutter/material.dart';
import 'auth_view_model.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/data/repositories/work_repositories.dart';

class WorkViewModel extends ChangeNotifier {
  AuthViewModel _auth;
  final WorkRepositories _repo;
  WorkViewModel(this._auth, this._repo);

  void update(AuthViewModel auth) => _auth = auth;


  final List<WorkModel> _works = [];
  WorkModel? _selected;
  bool _loading = false;

  List<WorkModel> get works => List.unmodifiable(_works);
  WorkModel? get work => _selected;
  bool get isLoading  => _loading;

  bool get isReady =>
      _auth.status == AuthStatus.authenticated && _auth.user != null;

  String get _token {
    final t = _auth.jwt;
    if (t == null || t.isEmpty) throw Exception('Access token 없음');
    return t;
  }

  Future<void> getWorks() async {
    if (!isReady || _loading) return;
    _loading = true;
    notifyListeners();

    try {
      final results = await _repo.getWorks(_token);
      _works
        ..clear()
        ..addAll(results);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<WorkModel> createWork(WorkModel work) async {
    final result = await _repo.createWork(_token, work);
    _works.add(result.work);
    notifyListeners();
    return result.work;
  }

  Future<void> getWork(int id) async {
    final result = await _repo.getWork(_token, id);
    _selected = result.work;

    final i = _works.indexWhere((w) => w.id == id);
    if (i != -1) _works[i] = _selected!;
    notifyListeners();
  }

  Future<void> deleteWork(int id) async {
    await _repo.deleteWork(_token, id);

    _works.removeWhere((w) => w.id == id);
    if (_selected?.id == id) _selected = null;
    notifyListeners();
  }
}