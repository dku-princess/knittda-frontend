import 'dart:io';

import 'package:dio/dio.dart';
import 'package:knittda/app_config.dart';
import 'package:knittda/src/data/data_sources/article_api.dart';
import 'package:knittda/src/data/data_sources/authentication_api.dart';
import 'package:knittda/src/data/data_sources/banner_local_storage.dart';
import 'package:knittda/src/data/data_sources/directus_dio.dart';
import 'package:knittda/src/data/data_sources/feed_api.dart';
import 'package:knittda/src/data/data_sources/in_app_banner_api.dart';
import 'package:knittda/src/data/data_sources/project_api.dart';
import 'package:knittda/src/data/data_sources/record_api.dart';
import 'package:knittda/src/data/data_sources/report_api.dart';
import 'package:knittda/src/data/data_sources/report_data_source.dart';
import 'package:knittda/src/data/data_sources/secure_storage.dart';
import 'package:knittda/src/data/data_sources/social_login.dart';
import 'package:knittda/src/data/data_sources/social_login_apple.dart';
import 'package:knittda/src/data/data_sources/social_login_apple_dummy.dart';
import 'package:knittda/src/data/data_sources/social_login_kakao.dart';
import 'package:knittda/src/data/data_sources/user_storage.dart';
import 'package:knittda/src/data/repository/article_repository_impl.dart';
import 'package:knittda/src/data/repository/authentication_repository_impl.dart';
import 'package:knittda/src/data/repository/feed_api_repository_impl.dart';
import 'package:knittda/src/data/repository/in_app_banner_repository_impl.dart';
import 'package:knittda/src/data/repository/project_api_repository_impl.dart';
import 'package:knittda/src/data/repository/record_api_repository_impl.dart';
import 'package:knittda/src/data/repository/report_api_repository_impl.dart';
import 'package:knittda/src/domain/repository/article_repository.dart';
import 'package:knittda/src/domain/repository/authentication_repository.dart';
import 'package:knittda/src/domain/repository/feed_api_repository.dart';
import 'package:knittda/src/domain/repository/in_app_banner_repository.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';
import 'package:knittda/src/domain/repository/record_api_repository.dart';
import 'package:knittda/src/domain/repository/report_api_repository.dart';
import 'package:knittda/src/domain/use_case/auto_login_use_case.dart';
import 'package:knittda/src/domain/use_case/dismiss_banner_use_case.dart';
import 'package:knittda/src/domain/use_case/get_active_banner_use_case.dart';
import 'package:knittda/src/domain/use_case/get_feed_use_case.dart';
import 'package:knittda/src/domain/use_case/get_project_previews_use_case.dart';
import 'package:knittda/src/domain/use_case/order_projects_use_case.dart';
import 'package:knittda/src/domain/use_case/get_user_use_case.dart';
import 'package:knittda/src/domain/use_case/logout_use_case.dart';
import 'package:knittda/src/domain/use_case/setting_profile_image_use_case.dart';
import 'package:knittda/src/domain/use_case/signout_use_case.dart';
import 'package:knittda/src/domain/use_case/social_login_use_case.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
  final bannerLocalStorage = BannerLocalStorage(sharedPrefs);
  await bannerLocalStorage.cleanUpOldKeys();

  final SocialLogin appleLogin = Platform.isIOS
      ? SocialLoginApple()
      : SocialLoginAppleDummy();

  final packageInfo = await PackageInfo.fromPlatform();
  final appVersion = packageInfo.version;

  return [
    Provider<Dio>(
      create: (_) {
        final dio = Dio(BaseOptions(baseUrl: AppConfig.apiBaseUrl));
        dio.interceptors.add(AuthInterceptor(tokenStorage));
        return dio;
      },
    ),
    Provider<DirectusDio>(
      create: (_) {
        final dio = Dio(BaseOptions(baseUrl: AppConfig.directusBaseUrl));
        dio.interceptors.add(AuthInterceptor(tokenStorage));
        return DirectusDio(dio);
      },
    ),

    ProxyProvider<Dio, ReportApi>(update: (context, dio, _) => ReportApi(dio)),
    ProxyProvider<ReportApi, ReportApiRepository>(
      update: (context, api, _) =>
          ReportApiRepositoryImpl(api, reportDataSource),
    ),

    ProxyProvider<Dio, AuthenticationApi>(
      update: (context, dio, _) => AuthenticationApi(dio),
    ),
    ProxyProvider<AuthenticationApi, AuthenticationRepository>(
      update: (context, api, _) => AuthenticationRepositoryImpl(
        api,
        SocialLoginKakao(),
        appleLogin,
        tokenStorage,
        userStorage,
      ),
    ),
    ProxyProvider<AuthenticationRepository, SocialLoginUseCase>(
      update: (context, authRepository, _) =>
          SocialLoginUseCase(authRepository),
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
      SignoutUseCase
    >(
      update: (context, authRepository, reportRepository, _) =>
          SignoutUseCase(authRepository, reportRepository),
    ),
    ProxyProvider2<
      AuthenticationRepository,
      ReportApiRepository,
      LogoutUseCase
    >(
      update: (context, authRepository, reportRepository, _) =>
          LogoutUseCase(authRepository, reportRepository),
    ),
    ProxyProvider<AuthenticationRepository, SettingProfileImageUseCase>(
      update: (context, authRepository, _) =>
          SettingProfileImageUseCase(authRepository),
    ),
    ProxyProvider<AuthenticationRepository, GetUserUseCase>(
      update: (context, authRepository, _) => GetUserUseCase(authRepository),
    ),

    ProxyProvider<Dio, ProjectApi>(
      update: (context, dio, _) => ProjectApi(dio),
    ),
    ProxyProvider<ProjectApi, ProjectApiRepository>(
      update: (context, api, _) => ProjectApiRepositoryImpl(api),
    ),
    ProxyProvider<ProjectApiRepository, OrderProjectsUseCase>(
      update: (context, repository, _) => OrderProjectsUseCase(repository),
    ),
    ProxyProvider<ProjectApiRepository, GetProjectPreviewsUseCase>(
      update: (context, repository, _) => GetProjectPreviewsUseCase(repository),
    ),

    ProxyProvider<Dio, FeedApi>(update: (context, dio, _) => FeedApi(dio)),
    ProxyProvider<FeedApi, FeedApiRepository>(
      update: (context, api, _) => FeedApiRepositoryImpl(api),
    ),
    ProxyProvider<FeedApiRepository, GetFeedUseCase>(
      update: (context, repository, _) => GetFeedUseCase(repository),
    ),

    ProxyProvider<Dio, RecordApi>(update: (context, dio, _) => RecordApi(dio)),
    ProxyProvider<RecordApi, RecordApiRepository>(
      update: (context, api, _) => RecordApiRepositoryImpl(api),
    ),

    ProxyProvider<DirectusDio, ArticleApi>(
      update: (context, directusDio, _) =>
          ArticleApi(directusDio.dio, articleStatus: AppConfig.articleStatus),
    ),
    ProxyProvider<ArticleApi, ArticleRepository>(
      update: (context, api, _) => ArticleRepositoryImpl(api),
    ),

    ProxyProvider<DirectusDio, InAppBannerApi>(
      update: (context, directusDio, _) => InAppBannerApi(
        directusDio.dio,
        directusStatus: AppConfig.directusStatus,
      ),
    ),
    ProxyProvider<InAppBannerApi, InAppBannerRepository>(
      update: (context, api, _) => InAppBannerRepositoryImpl(api),
    ),
    ProxyProvider<InAppBannerRepository, GetActiveBannerUseCase>(
      update: (content, repository, _) => GetActiveBannerUseCase(
        repository: repository,
        localStorage: bannerLocalStorage,
        currentAppVersion: appVersion,
      ),
    ),
    Provider<DismissBannerUseCase>(
      create: (_) => DismissBannerUseCase(bannerLocalStorage),
    ),
  ];
}
