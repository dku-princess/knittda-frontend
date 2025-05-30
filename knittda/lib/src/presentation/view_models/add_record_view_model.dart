import 'package:flutter/cupertino.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/repositories/records_repository.dart';
import 'package:knittda/src/domain/use_case/create_record_use_case.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';

class AddRecordViewModel extends ChangeNotifier {
  AuthViewModel _auth;
  final CreateRecordUseCase _createUseCase;
  final RecordsRepository repository;

  AddRecordViewModel({
    required AuthViewModel authViewModel,
    required CreateRecordUseCase createRecordUseCase,
    required RecordsRepository recordsRepository,
  })  : _auth = authViewModel,
        _createUseCase = createRecordUseCase,
        repository = recordsRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get errorMessage => _error;

  RecordModel? get createdRecord => repository.record;

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  Future<bool> createRecord(RecordModel record) async {
    final token = _auth.jwt;
    if (token == null) {
      _error = '로그인이 필요합니다.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    try {
      await _createUseCase(token, record);
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