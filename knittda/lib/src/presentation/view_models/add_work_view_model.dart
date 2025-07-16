import 'package:flutter/material.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:knittda/src/domain/use_case/create_work_use_case.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/domain/use_case/work_use_cases.dart';
import 'auth_view_model.dart';

class AddWorkViewModel extends ChangeNotifier {
  final WorkUseCases useCases;
  final WorkRepository repository;

  AddWorkViewModel({
    required this.useCases,
    required this.repository,
  });

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
    _setLoading(true);
    try {
      await useCases.createWork(work);
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