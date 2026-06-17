import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final AnalyticsService instance = AnalyticsService._();
  AnalyticsService._();

  final FirebaseAnalytics _fa = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _fa);

  // 사용자 식별
  Future<void> setUserId(String? userId) => _fa.setUserId(id: userId);

  // 인증
  Future<void> logLogin(String provider) =>
      _fa.logLogin(loginMethod: provider);

  Future<void> logLogout() => _fa.logEvent(name: 'logout');

  // 탭 전환
  Future<void> logTabSelect(String tabName) =>
      _fa.logEvent(name: 'tab_select', parameters: {'tab_name': tabName});

  // 화면 조회 (IndexedStack 등 Navigator route를 거치지 않는 화면 전환용)
  Future<void> logScreenView(String screenName) =>
      _fa.logScreenView(screenName: screenName, screenClass: screenName);

  // 콘텐츠 조회
  Future<void> logViewArticle(String articleId) =>
      _fa.logEvent(name: 'view_article', parameters: {'article_id': articleId});

  Future<void> logViewAnnouncement(String announcementId) => _fa.logEvent(
    name: 'view_announcement',
    parameters: {'announcement_id': announcementId},
  );

  Future<void> logViewProject(String projectId) =>
      _fa.logEvent(name: 'view_project', parameters: {'project_id': projectId});

  // 작품 CRUD
  Future<void> logCreateProject() => _fa.logEvent(name: 'create_project');

  Future<void> logEditProject(String projectId) => _fa.logEvent(
    name: 'edit_project',
    parameters: {'project_id': projectId},
  );

  Future<void> logDeleteProject(String projectId) => _fa.logEvent(
    name: 'delete_project',
    parameters: {'project_id': projectId},
  );

  // 기록 CRUD
  Future<void> logAddRecord(String projectId) =>
      _fa.logEvent(name: 'add_record', parameters: {'project_id': projectId});

  Future<void> logEditRecord(String recordId) =>
      _fa.logEvent(name: 'edit_record', parameters: {'record_id': recordId});

  Future<void> logDeleteRecord(String recordId) =>
      _fa.logEvent(name: 'delete_record', parameters: {'record_id': recordId});

  // 검색
  Future<void> logSearch(String term, String type) =>
      _fa.logSearch(searchTerm: term, parameters: {'search_type': type});

  // 배너
  Future<void> logBannerClick(String bannerId, String actionType) =>
      _fa.logEvent(name: 'banner_click', parameters: {
        'banner_id': bannerId,
        'action_type': actionType,
      });

  Future<void> logBannerDismiss(String bannerId, String dismissType) =>
      _fa.logEvent(name: 'banner_dismiss', parameters: {
        'banner_id': bannerId,
        'dismiss_type': dismissType,
      });

  // 피드 페이지네이션
  Future<void> logLoadMore(String contentType, int page) =>
      _fa.logEvent(name: 'load_more', parameters: {
        'content_type': contentType,
        'page': page,
      });

  // 공유
  Future<void> logShare(String contentType, String itemId) =>
      _fa.logShare(contentType: contentType, itemId: itemId, method: 'share_plus');

  // 프로필
  Future<void> logUpdateNickname() => _fa.logEvent(name: 'update_nickname');
}
