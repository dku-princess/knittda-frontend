import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/domain/use_case/delete_record_use_case.dart';
import 'package:knittda/src/domain/use_case/get_record_use_case.dart';
import 'package:knittda/src/domain/use_case/get_records_use_case.dart';
import 'package:knittda/src/domain/use_case/update_record_use_case.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';

class RecordViewModel extends ChangeNotifier {
  AuthViewModel _auth;
  final DeleteRecordUseCase _deleteUseCase;
  final GetRecordUseCase _getRecordUseCase;
  final GetRecordsUseCase _getRecordsUseCase;
  final UpdateRecordUseCase _updateRecordUseCase;

  RecordViewModel({
    required AuthViewModel authViewModel,
    required DeleteRecordUseCase deleteRecordUseCase,
    required GetRecordUseCase getRecordUseCase,
    required GetRecordsUseCase getRecordsUseCase,
    required UpdateRecordUseCase updateRecordUseCase,
  })  : _auth = authViewModel,
        _deleteUseCase = deleteRecordUseCase,
        _getRecordUseCase = getRecordUseCase,
        _getRecordsUseCase = getRecordsUseCase,
        _updateRecordUseCase = updateRecordUseCase;

  void update(AuthViewModel auth) {
    _auth = auth;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get errorMessage => _error;

  RecordModel? _created;
  RecordModel? get createdRecord => _created;

  RecordModel? _gotRecord;
  RecordModel? get gotRecord => _gotRecord;

  List<RecordModel>? _gotRecords;
  List<RecordModel>? get gotRecords => _gotRecords;

  RecordModel? _updateRecord;
  RecordModel? get editRecord => _updateRecord;

  void reset({bool all = false}) {
    _created = null;
    _error = null;
    _gotRecord = null;
    _updateRecord = null;
    if (all) {
      _gotRecords = null;
    }
    notifyListeners();
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  Future<bool> udateRecord(RecordModel record) async {
    final token = _auth.jwt;
    if (token == null) {
      _error = '로그인이 필요합니다.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    try {
      final result = await _updateRecordUseCase(token, record);
      _updateRecord = result.record;
      _error   = null;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
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
      final result = await _getRecordUseCase(token, recordId);
      _gotRecord = result.record;
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
      final result = await _getRecordsUseCase(token, projectId);
      _gotRecords = result;
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

      // 목록에서 직접 제거
      final index = _gotRecords?.indexWhere((r) => r.id == recordId);
      if (index != null && index != -1) {
        _gotRecords!.removeAt(index);
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