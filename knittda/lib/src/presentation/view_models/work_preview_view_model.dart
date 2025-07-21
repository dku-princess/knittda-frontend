import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/work_preview_model.dart';
import 'package:knittda/src/domain/use_case/work_use_cases.dart';

class WorkPreviewViewModel extends ChangeNotifier {
  final WorkUseCases useCases;

  WorkPreviewViewModel(this.useCases);

  // ───────────────────────────────── 상태
  final List<WorkPreviewModel> _previews = [];
  bool _isLoading = false;
  String? _error;

  // ───────────────────────────────── getters
  List<WorkPreviewModel> get previews => List.unmodifiable(_previews);
  bool get isLoading => _isLoading;
  String? get error => _error;

  // ───────────────────────────────── public API
  Future<void> load() async {
    if (_isLoading) return;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final items = await useCases.getWorkPreviews();
      _previews
        ..clear()
        ..addAll(items);
      _error = null;
    } catch (_) {
      _error = '작품 목록을 불러오는데 실패했습니다.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Pull-to-refresh 용도로 그대로 노출
  Future<void> refresh() => load();

}