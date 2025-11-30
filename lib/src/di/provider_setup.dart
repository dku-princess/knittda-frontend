import 'package:dio/dio.dart';
import 'package:knittda/env.dart';
import 'package:knittda/src/data/data_sources/authentication_api.dart';
import 'package:knittda/src/data/data_sources/feed_api.dart';
import 'package:knittda/src/data/data_sources/project_api.dart';
import 'package:knittda/src/data/data_sources/record_api.dart';
import 'package:knittda/src/data/data_sources/report_api.dart';
import 'package:knittda/src/data/data_sources/report_data_source.dart';
import 'package:knittda/src/data/data_sources/secure_storage.dart';
import 'package:knittda/src/data/data_sources/social_login_apple.dart';
import 'package:knittda/src/data/data_sources/social_login_kakao.dart';
import 'package:knittda/src/data/data_sources/user_storage.dart';
import 'package:knittda/src/data/repository/authentication_repository_impl.dart';
import 'package:knittda/src/data/repository/feed_api_repository_impl.dart';
import 'package:knittda/src/data/repository/project_api_repository_impl.dart';
import 'package:knittda/src/data/repository/record_api_repository_impl.dart';
import 'package:knittda/src/data/repository/report_api_repository_impl.dart';
import 'package:knittda/src/domain/repository/authentication_repository.dart';
import 'package:knittda/src/domain/repository/feed_api_repository.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';
import 'package:knittda/src/domain/repository/record_api_repository.dart';
import 'package:knittda/src/domain/repository/report_api_repository.dart';
import 'package:knittda/src/domain/use_case/admin_login_use_case.dart';
import 'package:knittda/src/domain/use_case/auto_login_use_case.dart';
import 'package:knittda/src/domain/use_case/get_feed_use_case.dart';
import 'package:knittda/src/domain/use_case/get_project_previews_use_case.dart';
import 'package:knittda/src/domain/use_case/get_projects_use_case.dart';
import 'package:knittda/src/domain/use_case/logout_use_case.dart';
import 'package:knittda/src/domain/use_case/signout_use_case.dart';
import 'package:knittda/src/domain/use_case/social_login_use_case.dart';
import 'package:knittda/src/presentation/feed/feed_view_model.dart';
import 'package:knittda/src/presentation/project_previews/project_previews_view_model.dart';
import 'package:knittda/src/presentation/projects/projects_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_sources/auth_interceptor.dart';
import '../data/data_sources/token_storage.dart';

Future<List<SingleChildWidget>> getProviders() async {
 final secureStorage = SecureStorage();
  final tokenStorage = TokenStorage(secureStorage);
  final userStorage = UserStorage(secureStorage);

  final sharedPrefs = SharedPreferencesAsync();
  final reportDataSource = ReportDataSource(sharedPrefs);

  return [
    Provider<Dio>(
      create: (_) {
        final dio = Dio(BaseOptions(baseUrl: Env.apiBaseUrl));
        dio.interceptors.add(AuthInterceptor(tokenStorage));
        return dio;
      },
    ),

    ProxyProvider<Dio, ReportApi>(update: (context, dio, _) => ReportApi(dio)),
    ProxyProvider<ReportApi, ReportApiRepository>(
      update: (context, api, _) => ReportApiRepositoryImpl(api, reportDataSource),
    ),

    ProxyProvider<Dio, AuthenticationApi>(
      update: (context, dio, _) => AuthenticationApi(dio),
    ),
    ProxyProvider<AuthenticationApi, AuthenticationRepository>(
      update: (context, api, _) => AuthenticationRepositoryImpl(
        api,
        SocialLoginKakao(),
        SocialLoginApple(),
        tokenStorage,
        userStorage,
      ),
    ),
    ProxyProvider2<
      AuthenticationRepository,
      ReportApiRepository,
      SocialLoginUseCase
    >(
      update: (context, authRepository, reportRepository, _) =>
          SocialLoginUseCase(authRepository, reportRepository),
    ),
    ProxyProvider2<
      AuthenticationRepository,
      ReportApiRepository,
      AutoLoginUseCase
    >(
      update: (context, authRepository, reportRepository, _) =>
          AutoLoginUseCase(authRepository, reportRepository),
    ),
    ProxyProvider2<
        AuthenticationRepository,
        ReportApiRepository,
        AdminLoginUseCase
    >(
      update: (context, authRepository, reportRepository, _) =>
          AdminLoginUseCase(authRepository, reportRepository),
    ),
    ProxyProvider2<
      AuthenticationRepository,
      ReportApiRepository,
      SignoutUseCase
    >(
      update: (context, authRepository, reportRepository, _) =>
          SignoutUseCase(authRepository, reportRepository),
    ),
    ProxyProvider<AuthenticationRepository, LogoutUseCase>(
      update: (context, authRepository, _) => LogoutUseCase(authRepository),
    ),

    ProxyProvider<Dio, ProjectApi>(
      update: (context, dio, _) => ProjectApi(dio),
    ),
    ProxyProvider<ProjectApi, ProjectApiRepository>(
      update: (context, api, _) => ProjectApiRepositoryImpl(api),
    ),
    ProxyProvider<ProjectApiRepository, GetProjectsUseCase>(
      update: (context, repository, _) => GetProjectsUseCase(repository),
    ),
    ProxyProvider<ProjectApiRepository, GetProjectPreviewsUseCase>(
      update: (context, repository, _) => GetProjectPreviewsUseCase(repository),
    ),
    ChangeNotifierProvider<ProjectsViewModel>(
      create: (context) =>
          ProjectsViewModel(context.read<GetProjectsUseCase>()),
    ),
    ChangeNotifierProvider<ProjectPreviewsViewModel>(
      create: (context) =>
          ProjectPreviewsViewModel(context.read<GetProjectPreviewsUseCase>()),
    ),

    ProxyProvider<Dio, FeedApi>(update: (context, dio, _) => FeedApi(dio)),
    ProxyProvider<FeedApi, FeedApiRepository>(
      update: (context, api, _) => FeedApiRepositoryImpl(api),
    ),
    ProxyProvider<FeedApiRepository, GetFeedUseCase>(
      update: (context, repository, _) => GetFeedUseCase(repository),
    ),
    ChangeNotifierProvider<FeedViewModel>(
      create: (context) => FeedViewModel(context.read<GetFeedUseCase>()),
    ),

    ProxyProvider<Dio, RecordApi>(update: (context, dio, _) => RecordApi(dio)),
    ProxyProvider<RecordApi, RecordApiRepository>(
      update: (context, api, _) => RecordApiRepositoryImpl(api),
    ),
  ];
}
