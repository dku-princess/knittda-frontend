import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/design_model.dart';
import 'package:knittda/src/data/repositories/design_repositories.dart';

class SearchPatternsUseCase {
  final DesignRepositories designRepositories;

  SearchPatternsUseCase({
    required this.designRepositories,
  });

  Future<List<DesignModel>> call(String keyword) async {
    try {
      final result = await designRepositories.searchDesign(keyword);
      return result;
    } catch (e, stack) {
      debugPrint('GetRecordUseCase 오류: $e\n$stack');
      rethrow; // 호출 측에서 catch 가능하게 재던짐
    }
  }
}