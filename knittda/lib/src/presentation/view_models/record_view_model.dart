import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/repositories/records_repository.dart';
import 'package:knittda/src/domain/use_case/delete_record_use_case.dart';
import 'package:knittda/src/domain/use_case/get_record_use_case.dart';
import 'package:knittda/src/domain/use_case/get_records_use_case.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';

class RecordViewModel extends ChangeNotifier {
  AuthViewModel _auth;
  final DeleteRecordUseCase _deleteUseCase;
  final GetRecordUseCase _getRecordUseCase;
  final GetRecordsUseCase _getRecordsUseCase;
  final RecordsRepository repository;

  RecordViewModel({
    required AuthViewModel authViewModel,
    required DeleteRecordUseCase deleteRecordUseCase,
    required GetRecordUseCase getRecordUseCase,
    required GetRecordsUseCase getRecordsUseCase,
    required RecordsRepository recordsRepository,
  })  : _auth = authViewModel,
        _deleteUseCase = deleteRecordUseCase,
        _getRecordUseCase = getRecordUseCase,
        _getRecordsUseCase = getRecordsUseCase,
        repository = recordsRepository;

  void update(AuthViewModel auth) {
    _auth = auth;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get errorMessage => _error;

  RecordModel? get record => repository.record;

  List<RecordModel>? get records => repository.records;

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  Future<bool> getRecord(int recordId) async {
    final token = _auth.jwt;
    if (token == null) {
      _error = '로그인이 필요합니다.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    try {
      await _getRecordUseCase(token, recordId);
      _error   = null;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> getRecords(int projectId) async {
    final token = _auth.jwt;
    if (token == null) {
      _error = '로그인이 필요합니다.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    try {
      await _getRecordsUseCase(token, projectId);
      _error   = null;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteRecord(int recordId) async {
    final token = _auth.jwt;
    if (token == null) {
      _error = '로그인이 필요합니다.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    try {
      await _deleteUseCase(token, recordId);
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