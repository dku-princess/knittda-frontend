import 'package:flutter/foundation.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/domain/use_case/record_use_cases.dart';

class RecordDetailViewModel extends ChangeNotifier {
  final RecordUseCases useCases;

  RecordDetailViewModel(
    this.useCases,
  );

  bool _isLoading = false;
  String? _error;
  RecordModel? _record;

  bool get isLoading => _isLoading;
  String? get error => _error;
  RecordModel? get record => _record;

  Future<void> load(int recordId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _record = await useCases.getRecord(recordId);
    } catch (e) {
      _error = '기록을 불러오는데 실패했습니다.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setRecord(RecordModel newRecord) {
    _record = newRecord;
    notifyListeners();
  }

}