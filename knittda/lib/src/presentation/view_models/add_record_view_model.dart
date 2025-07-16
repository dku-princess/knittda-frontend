import 'package:flutter/cupertino.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/repositories/record_repository.dart';
import 'package:knittda/src/domain/use_case/create_record_use_case.dart';
import 'package:knittda/src/domain/use_case/record_use_cases.dart';

class AddRecordViewModel extends ChangeNotifier {
  final RecordUseCases useCases;
  final RecordRepository repository;

  AddRecordViewModel({
    required this.useCases,
    required this.repository,
  });

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
    _setLoading(true);
    try {
      await useCases.createRecord(record);
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