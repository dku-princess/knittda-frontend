import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/design_model.dart';
import 'package:knittda/src/domain/use_case/search_design_use_case.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchDesignUseCase _searchDesignUseCase;

  SearchViewModel({
    required SearchDesignUseCase searchDesignUseCase,
  }) : _searchDesignUseCase = searchDesignUseCase;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get errorMessage => _error;

  List<DesignModel>? _searchDesigns;
  List<DesignModel>? get designs => _searchDesigns;

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  Future<bool> searchDesign(String keyword) async {
    _setLoading(true);

    try {
      final result = await _searchDesignUseCase(keyword);
      _searchDesigns = result;
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