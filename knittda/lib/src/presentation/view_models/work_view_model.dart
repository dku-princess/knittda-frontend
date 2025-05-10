import 'package:flutter/material.dart';
import 'auth_view_model.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/data/repositories/work_repositories.dart';

class WorkViewModel extends ChangeNotifier {
  late AuthViewModel _authViewModel;
  final WorkRepositories workRepositories;

  WorkViewModel(this._authViewModel, this.workRepositories);

  void update(AuthViewModel authViewModel) {
    _authViewModel = authViewModel;
    notifyListeners();
  }

  List<WorkModel> works = [];

  bool get isReady =>
      _authViewModel.status == AuthStatus.authenticated && _authViewModel.user != null;

  String get accessToken => _authViewModel.jwt ?? '';

  /// 작품 리스트 가져오기
  Future<void> getWorks() async {
    try {
      final result = await workRepositories.getWorks(accessToken);
      works = result;
      notifyListeners();
    } catch (e) {
      debugPrint("작품 조회 중 오류: $e");
      rethrow;
    }
  }

  /// 작품 생성하기
  Future<void> createWork({required WorkModel work}) async {
    try {
      final result = await workRepositories.createWork(accessToken, work);
      works.add(result.work); // 리스트에 추가
      notifyListeners();
    } catch (e) {
      debugPrint("작품 생성 중 오류: $e");
      rethrow;
    }
  }
}