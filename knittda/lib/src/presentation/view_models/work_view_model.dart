import 'package:flutter/material.dart';
import 'auth_view_model.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/data/repositories/work_repositories.dart';

class WorkViewModel extends ChangeNotifier {
  AuthViewModel _authViewModel;
  final WorkRepositories workRepositories;

  WorkViewModel(this._authViewModel, this.workRepositories);

  void update(AuthViewModel authViewModel) {
    _authViewModel = authViewModel;
    notifyListeners();
  }

  List<WorkModel> works = [];
  WorkModel? work;

  bool isLoading = false;

  bool get isReady =>
      _authViewModel.status == AuthStatus.authenticated && _authViewModel.user != null;

  String get accessToken => _authViewModel.jwt ?? '';

  //작품 삭제하기
  Future<void> deleteWork(int projectId) async {
    try {
      await workRepositories.deleteWork(accessToken, projectId);

      // 삭제 후 목록 최신화
      works.removeWhere((w) => w.id == projectId);

      // 상세 화면에서 사용 중일 경우 null 처리
      if (work?.id == projectId) {
        work = null;
      }

      notifyListeners();
    } catch (e) {
      debugPrint("작품 삭제 중 오류: $e");
      rethrow;
    }
  }

  Future<void> getWork(int projectId) async {
    try {
      final result = await workRepositories.getWork(accessToken, projectId);
      work = result.work;

      // 기존 목록에 존재하면 업데이트
      final index = works.indexWhere((w) => w.id == projectId);
      if (index != -1) {
        works[index] = work!;
      }

      notifyListeners();
    } catch (e) {
      debugPrint("작품 조회 중 오류: $e");
      rethrow;
    }
  }

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
  Future<WorkModel> createWork(WorkModel work) async {
    try {
      final result = await workRepositories.createWork(accessToken, work);
      works.add(result.work); // 리스트에 추가
      notifyListeners();
      return result.work;
    } catch (e) {
      debugPrint("작품 생성 중 오류: $e");
      rethrow;
    }
  }
}