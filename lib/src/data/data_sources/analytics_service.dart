import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';
import 'package:knittda/src/domain/model/article/article_detail.dart';
import 'package:knittda/src/domain/model/article/article_section.dart';

class AnalyticsService {
  static final AnalyticsService instance = AnalyticsService._();
  AnalyticsService._();

  final FirebaseAnalytics _fa = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _fa);

  /// 화면 복귀 감지를 위한 전역 RouteObserver.
  /// `article_return`(작품 기록 화면에서 돌아오기) 측정에 사용한다.
  /// MaterialApp.navigatorObservers 에 등록해야 동작한다.
  static final RouteObserver<PageRoute<dynamic>> routeObserver =
      RouteObserver<PageRoute<dynamic>>();

  // ── 공통 파라미터 컨텍스트 (앱 시작 시 1회 설정) ──────────────────────
  String _environment = '';
  String _appVersion = '';

  /// 앱 부팅 시 1회 호출해 모든 이벤트에 붙는 공통 값을 설정한다.
  void configure({required String environment, required String appVersion}) {
    _environment = environment;
    _appVersion = appVersion;
  }

  /// GA4 파라미터 값은 100자 제한이므로 안전하게 잘라낸다.
  String _clip(String value) =>
      value.length <= 100 ? value : value.substring(0, 100);

  /// 모든 아티클 이벤트에 붙는 공통 파라미터.
  Map<String, Object> _articleCommon(ArticleDetail article, String source) {
    final author = article.interviewee.isNotEmpty
        ? article.interviewee
        : article.editor;
    return {
      'article_id': article.id,
      'article_slug': _clip(article.slug),
      'article_title': _clip(article.title),
      'article_status': _clip(article.status),
      'article_sort': article.sort,
      'author_name': _clip(author),
      // 실험 그룹 식별자. id는 환경(beta/prod)마다 달라질 수 있어 안정적인
      // slug를 그대로 사용한다. A/B1/B2 라벨링은 GA4/분석 단계에서 매핑.
      'variant': _clip(article.slug),
      'source': _clip(source),
      'environment': _clip(_environment),
      'app_version': _clip(_appVersion),
    };
  }

  /// 섹션 레벨 이벤트 공통 파라미터 (article 공통 + 섹션 식별자).
  Map<String, Object> _sectionCommon(
    ArticleDetail article,
    String source,
    ArticleSection section,
    int sectionIndex,
  ) {
    final item = section.item ?? const <String, dynamic>{};
    return {
      ..._articleCommon(article, source),
      'section_collection': _clip(section.collection),
      'section_sort': section.sort,
      'section_index': sectionIndex,
      'tracking_label': _clip((item['tracking_label'] ?? '').toString()),
      'section_title': _clip((item['title'] ?? '').toString()),
    };
  }

  // ── C-2 아티클 상세 이벤트 ────────────────────────────────────────────

  /// article_view — 상세 로드 성공 직후 1회 (공통 파라미터 확장판).
  Future<void> logArticleView(
    ArticleDetail article, {
    String source = 'article_list',
  }) => _fa.logEvent(
    name: 'article_view',
    parameters: _articleCommon(article, source),
  );

  /// article_section_view — 섹션이 뷰포트 50% 이상 노출된 최초 1회.
  Future<void> logArticleSectionView(
    ArticleDetail article,
    String source,
    ArticleSection section,
    int sectionIndex,
  ) => _fa.logEvent(
    name: 'article_section_view',
    parameters: _sectionCommon(article, source, section, sectionIndex),
  );

  /// article_section_read_time — 섹션 누적 가시 시간(이탈/언마운트 시 1회).
  Future<void> logArticleSectionReadTime(
    ArticleDetail article,
    String source,
    ArticleSection section,
    int sectionIndex,
    int readTimeMs,
  ) => _fa.logEvent(
    name: 'article_section_read_time',
    parameters: {
      ..._sectionCommon(article, source, section, sectionIndex),
      'read_time_ms': readTimeMs,
    },
  );

  /// project_card_view — 프로젝트(작품 기록) 카드 노출.
  Future<void> logProjectCardView(
    ArticleDetail article,
    String source, {
    required int projectId,
    required int projectPosition,
  }) => _fa.logEvent(
    name: 'project_card_view',
    parameters: {
      ..._articleCommon(article, source),
      'project_id': projectId,
      'project_position': projectPosition,
    },
  );

  /// project_card_click — 프로젝트 카드 탭(작품 기록 보기). LG2 opt-in 수요.
  Future<void> logProjectCardClick(
    ArticleDetail article,
    String source,
    ArticleSection section,
    int sectionIndex, {
    required int projectId,
    required int projectPosition,
  }) => _fa.logEvent(
    name: 'project_card_click',
    parameters: {
      ..._sectionCommon(article, source, section, sectionIndex),
      'project_id': projectId,
      'project_position': projectPosition,
    },
  );

  /// article_return — 작품 기록 화면에서 아티클 상세로 복귀. LG2 누수 진단.
  Future<void> logArticleReturn(
    ArticleDetail article,
    String source, {
    required int fromProjectId,
    required int awayMs,
  }) => _fa.logEvent(
    name: 'article_return',
    parameters: {
      ..._articleCommon(article, source),
      'from_project_id': fromProjectId,
      'away_ms': awayMs,
    },
  );

  /// pattern_link_click — 구매 버튼 탭. Primary(구매 의향 종착 지표).
  Future<void> logPatternLinkClick(
    ArticleDetail article,
    String source,
    ArticleSection section,
    int sectionIndex, {
    required String buttonText,
    required String buttonUrl,
  }) => _fa.logEvent(
    name: 'pattern_link_click',
    parameters: {
      ..._sectionCommon(article, source, section, sectionIndex),
      'button_text': _clip(buttonText),
      'button_url': _clip(buttonUrl),
      'purchase_section_sort': section.sort,
    },
  );

  /// external_pattern_page_open — 외부 판매 URL 실제 오픈 성공.
  Future<void> logExternalPatternPageOpen(
    ArticleDetail article,
    String source, {
    required String buttonUrl,
  }) => _fa.logEvent(
    name: 'external_pattern_page_open',
    parameters: {
      ..._articleCommon(article, source),
      'button_url': _clip(buttonUrl),
    },
  );

  /// note_article_link_click — note 본문 내 아티클 링크 탭(재진입).
  Future<void> logNoteArticleLinkClick(
    ArticleDetail article,
    String source, {
    required String targetSlug,
  }) => _fa.logEvent(
    name: 'note_article_link_click',
    parameters: {
      ..._articleCommon(article, source),
      'target_slug': _clip(targetSlug),
    },
  );

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
  Future<void> logViewAnnouncement(String announcementId) => _fa.logEvent(
    name: 'view_announcement',
    parameters: {'announcement_id': announcementId},
  );

  /// 작품 상세 조회. [source]로 진입 경로를 구분한다.
  /// 예: project_list(작품 탭) / article_detail(아티클 내 작품 카드) / feed / feed_search
  Future<void> logViewProject(String projectId, {String source = 'unknown'}) =>
      _fa.logEvent(
        name: 'view_project',
        parameters: {'project_id': projectId, 'source': _clip(source)},
      );

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
