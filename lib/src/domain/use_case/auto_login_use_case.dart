import 'package:flutter/foundation.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/user.dart';
import 'package:knittda/src/domain/repository/authentication_repository.dart';
import 'package:knittda/src/domain/repository/report_api_repository.dart';

class AutoLoginUseCase {
  final AuthenticationRepository _authenticationRepository;
  final ReportApiRepository _reportApiRepository;

  AutoLoginUseCase(this._authenticationRepository, this._reportApiRepository);

  Future<Result<void>> call() async {
    debugPrint('[AutoLoginUseCase] 저장된 토큰 조회 시작');
    final token = await _authenticationRepository.getStoredToken();
    debugPrint('[AutoLoginUseCase] 저장된 토큰: ${token != null ? '있음' : '없음'}');

    if (token == null) {
      return Result.error('no_token');
    }

    debugPrint('[AutoLoginUseCase] 저장된 유저 조회 시작');
    final storedUser = await _authenticationRepository.getStoredUser();
    debugPrint('[AutoLoginUseCase] 저장된 유저: ${storedUser?.id ?? '없음'}');

    debugPrint('[AutoLoginUseCase] 서버 인증(getAuthMe) 시작');
    final result = await _authenticationRepository.getAuthMe();

    if (result is Success<User>) {
      final newUser = result.data;
      debugPrint('[AutoLoginUseCase] getAuthMe 성공, userId: ${newUser.id}');

      if (storedUser != null && storedUser.id != newUser.id) {
        debugPrint('[AutoLoginUseCase] 유저 변경 감지, 리포트 초기화');
        await _reportApiRepository.clearReport();
      }

      return Result.success(null);
    } else {
      final error = (result as Error).e;
      debugPrint('[AutoLoginUseCase] getAuthMe 실패: $error → 로컬 인증 정보 초기화');
      await _authenticationRepository.clearLocalAuth();
      await _reportApiRepository.clearReport();
      return Result.error('token_invalid');
    }
  }
}
