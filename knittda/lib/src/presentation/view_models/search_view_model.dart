import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/design_model.dart';
import 'package:knittda/src/data/repositories/design_repositories.dart';

class SearchViewModel extends ChangeNotifier {
  final DesignRepositories designRepositories;

  SearchViewModel(this.designRepositories);

  List<DesignModel> _designs = [];
  List<DesignModel> get designs => _designs;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> search(String keyword) async {
    if (keyword.isEmpty) {
      _designs = [];
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      notifyListeners();

      final result = await designRepositories.searchDesign(keyword);
      _designs = result;
    } catch (e) {
      debugPrint("검색 오류: $e");
      _designs = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    _designs = [];
    notifyListeners();
  }
}