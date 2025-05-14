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

  String get accessToken {
    final token = _authViewModel.jwt;
    if (token == null || token.isEmpty) {
      throw Exception("Access token is not available");
    }
    return token;
  }

  Future<void> deleteWork(int projectId) async {
    try {
      await workRepositories.deleteWork(accessToken, projectId);
      works.removeWhere((w) => w.id == projectId);
      if (work?.id == projectId) work = null;
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

  Future<void> getWorks() async {
    if (!isReady) return;
    isLoading = true;
    notifyListeners();

    try {
      final result = await workRepositories.getWorks(accessToken);
      works = result;
    } catch (e) {
      debugPrint("작품 조회 중 오류: $e");
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<WorkModel> createWork(WorkModel work) async {
    try {
      final result = await workRepositories.createWork(accessToken, work);
      works.add(result.work);
      notifyListeners();
      return result.work;
    } catch (e) {
      debugPrint("작품 생성 중 오류: $e");
      rethrow;
    }
  }
}