import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/domain/use_case/create_record_use_case.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';

class RecordViewModel extends ChangeNotifier {
  AuthViewModel _auth;
  CreateRecordUseCase _useCase;

  RecordViewModel({
    required AuthViewModel authViewModel,
    required CreateRecordUseCase useCase,
  })  : _auth = authViewModel,
        _useCase = useCase;

  void update(AuthViewModel auth) {
    _auth    = auth;
    notifyListeners();
  }

  // void update(AuthViewModel auth, CreateRecordUseCase useCase) {
  //   _auth    = auth;
  //   _useCase = useCase;
  //   notifyListeners();
  // }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get errorMessage => _error;

  RecordModel? _created;
  RecordModel? get createdRecord => _created;

  Future<bool> addRecord(RecordModel record) async {
    final token = _auth.jwt;
    if (token == null) {
      _error = '로그인이 필요합니다.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    try {
      final result = await _useCase(token, record);
      _created = result.record;
      _error   = null;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void reset() {
    _created = null;
    _error   = null;
    notifyListeners();
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}