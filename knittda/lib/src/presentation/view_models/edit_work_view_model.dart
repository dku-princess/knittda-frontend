import 'package:flutter/material.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:knittda/src/domain/use_case/update_work_use_case.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/domain/use_case/work_use_cases.dart';
import 'auth_view_model.dart';

class EditWorkViewModel extends ChangeNotifier {
  final WorkUseCases useCases;
  final WorkRepository repository;

  EditWorkViewModel({
    required this.useCases,
    required this.repository,
  });

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
    _setLoading(true);
    try {
      await useCases.updateWork(work);
      _error = null;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Future<bool> updateWorkStatus(WorkModel work) async {
  //   final token = _auth.jwt;
  //   if (token == null) {
  //     _error = '로그인이 필요합니다.';
  //     notifyListeners();
  //     return false;
  //   }
  //
  //   _setLoading(true);
  //   try {
  //     await repository.updateWorkStatus(token, work);
  //     _error = null;
  //     return true;
  //   } catch (e) {
  //     _error = e.toString();
  //     return false;
  //   } finally {
  //     _setLoading(false);
  //   }
  // }
}