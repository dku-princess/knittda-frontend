import 'package:flutter/material.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:knittda/src/domain/use_case/work_use_cases.dart';
import 'package:knittda/src/data/models/work_model.dart';

class WorkViewModel extends ChangeNotifier {
  final WorkUseCases useCases;
  final WorkRepository repository;

  WorkViewModel({
    required this.useCases,
    required this.repository,
  });

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
    _setLoading(true);
    try {
      await useCases.getWork(projectId);
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
    _setLoading(true);
    try {
      await useCases.getWorks();
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
    _setLoading(true);
    try {
      await useCases.deleteWork(projectId);
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