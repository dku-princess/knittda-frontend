import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/data/data_sources/analytics_service.dart';
import 'package:knittda/src/domain/model/article/article_detail.dart';
import 'package:knittda/src/domain/model/article/article_section.dart';
import 'package:knittda/src/domain/model/article/note_section.dart';
import 'package:knittda/src/domain/model/article/pattern_section.dart';
import 'package:knittda/src/domain/model/article/project_section.dart';
import 'package:knittda/src/domain/model/article/purchase_link_section.dart';
import 'package:knittda/src/domain/model/article/qa_section.dart';
import 'package:knittda/src/domain/repository/article_repository.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';
import 'package:knittda/src/domain/repository/record_api_repository.dart';
import 'package:knittda/src/domain/use_case/delete_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_article_previews_use_case.dart';
import 'package:knittda/src/domain/use_case/get_my_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_records_projects_use_case.dart';
import 'package:knittda/src/domain/use_case/get_user_use_case.dart';
import 'package:knittda/src/domain/use_case/update_project_use_case.dart';
import 'package:knittda/src/presentation/article_detail/article_detail_view_model.dart';
import 'package:knittda/src/presentation/article_detail/components/note_section_widget.dart';
import 'package:knittda/src/presentation/article_detail/components/pattern_section_widget.dart';
import 'package:knittda/src/presentation/article_detail/components/project_section_widget.dart';
import 'package:knittda/src/presentation/article_detail/components/purchase_link_section_widget.dart';
import 'package:knittda/src/presentation/article_detail/components/qa_section_widget.dart';
import 'package:knittda/src/presentation/project_details/project_details_screen.dart';
import 'package:knittda/src/presentation/project_details/project_details_view_model.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:knittda/src/core/theme/theme.dart';

/// 섹션별 가시 시간 누적 상태 (article_section_read_time 계산용).
class _SectionAccum {
  final ArticleSection section;
  int accumulatedMs = 0;
  DateTime? visibleSince;

  _SectionAccum(this.section);
}

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({super.key});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen>
    with RouteAware {
  // 가시율 50% 이상을 "노출"로 판단, 1초 이상 누적을 "실소비"로 판단
  static const double _visibleThreshold = 0.5;
  static const int _readTimeThresholdMs = 1000;

  late ArticleDetailViewModel _viewModel;

  // section_view / project_card_view 중복 발화 방지용
  final Set<int> _viewedSections = {};
  // 섹션별 가시 시간 누적
  final Map<int, _SectionAccum> _sectionAccums = {};
  // 다른 화면이 위에 덮여 측정을 일시정지한 섹션(복귀 시 측정 재개용)
  final Set<int> _pausedVisibleSections = {};

  // article_return(복귀율) 측정용 — 프로젝트 카드 탭으로 push한 상태 추적
  int? _pendingProjectId;
  DateTime? _projectPushTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = context.read<ArticleDetailViewModel>();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      AnalyticsService.routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    AnalyticsService.routeObserver.unsubscribe(this);
    _flushReadTimes();
    super.dispose();
  }

  @override
  void didPushNext() {
    // 다른 화면(작품 기록/노트 링크)이 위에 push되면 읽기 시간 누적을 일시정지한다.
    // VisibilityDetector는 라우트 가려짐(z-order)을 감지하지 못해, 멈추지 않으면
    // 떠나 있는 시간까지 article_section_read_time에 합산되어 과대 집계된다.
    final now = DateTime.now();
    _pausedVisibleSections.clear();
    _sectionAccums.forEach((sectionIndex, accum) {
      final since = accum.visibleSince;
      if (since != null) {
        accum.accumulatedMs += now.difference(since).inMilliseconds;
        accum.visibleSince = null;
        _pausedVisibleSections.add(sectionIndex);
      }
    });
  }

  @override
  void didPopNext() {
    // 작품 기록 화면(ProjectDetailsScreen)에서 아티클 상세로 복귀한 시점
    final projectId = _pendingProjectId;
    final pushTime = _projectPushTime;
    if (projectId != null && pushTime != null) {
      final article = _viewModel.state.article;
      if (article != null) {
        AnalyticsService.instance.logArticleReturn(
          article,
          _viewModel.source,
          fromProjectId: projectId,
          awayMs: DateTime.now().difference(pushTime).inMilliseconds,
        );
      }
      _pendingProjectId = null;
      _projectPushTime = null;
    }

    // 복귀 시, 일시정지했던 섹션의 가시 시간 측정을 재개한다.
    if (_pausedVisibleSections.isNotEmpty) {
      final resumeAt = DateTime.now();
      for (final sectionIndex in _pausedVisibleSections) {
        _sectionAccums[sectionIndex]?.visibleSince = resumeAt;
      }
      _pausedVisibleSections.clear();
    }
  }

  /// 언마운트/이탈 시 누적 가시 시간이 임계 이상인 섹션을 1회 전송
  void _flushReadTimes() {
    final article = _viewModel.state.article;
    if (article == null) return;
    final now = DateTime.now();
    _sectionAccums.forEach((sectionIndex, accum) {
      var total = accum.accumulatedMs;
      final since = accum.visibleSince;
      if (since != null) {
        total += now.difference(since).inMilliseconds;
      }
      if (total >= _readTimeThresholdMs) {
        AnalyticsService.instance.logArticleSectionReadTime(
          article,
          _viewModel.source,
          accum.section,
          sectionIndex,
          total,
        );
      }
    });
  }

  void _handleSectionVisibility(
    ArticleDetail article,
    ArticleSection section,
    int sectionIndex,
    double fraction,
  ) {
    final accum = _sectionAccums.putIfAbsent(
      sectionIndex,
      () => _SectionAccum(section),
    );
    final now = DateTime.now();

    if (fraction >= _visibleThreshold) {
      accum.visibleSince ??= now;
      // 최초 노출 1회만 section_view 발화
      if (_viewedSections.add(sectionIndex)) {
        AnalyticsService.instance.logArticleSectionView(
          article,
          _viewModel.source,
          section,
          sectionIndex,
        );
        _logProjectCardViewsIfNeeded(article, section);
      }
    } else {
      final since = accum.visibleSince;
      if (since != null) {
        accum.accumulatedMs += now.difference(since).inMilliseconds;
        accum.visibleSince = null;
      }
    }
  }

  /// project_section 최초 노출 시, 렌더된 카드별 project_card_view 발화
  void _logProjectCardViewsIfNeeded(
    ArticleDetail article,
    ArticleSection section,
  ) {
    if (section.collection != 'project_section' || section.item == null) return;
    try {
      final projectSection = ProjectSection.fromJson(section.item!);
      final validBlocks = projectSection.projectItemBlock
          .where((b) => _viewModel.getArticlePreview(b.projectId) != null)
          .toList();
      for (var i = 0; i < validBlocks.length; i++) {
        AnalyticsService.instance.logProjectCardView(
          article,
          _viewModel.source,
          projectId: validBlocks[i].projectId,
          projectPosition: i,
        );
      }
    } catch (e) {
      debugPrint('project_card_view 집계 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(scrolledUnderElevation: 0),

      body: Consumer<ArticleDetailViewModel>(
        builder: (context, viewModel, _) {
          final state = viewModel.state;

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          }

          final article = state.article;
          if (article == null) {
            return Center(child: Text('아티클을 찾을 수 없습니다.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 50, right: AppSpacing.space20, left: AppSpacing.space20),
            separatorBuilder: (context, index) {
              if (index == 0) {
                return const SizedBox(height: AppSpacing.space20);
              }
              return const SizedBox(height: 50);
            },
            itemCount: article.sections.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildHeader(article, viewModel);
              }

              final section = article.sections[index - 1];
              final sectionIndex = index - 1;
              final child = _buildSectionChild(
                context,
                viewModel,
                article,
                section,
                sectionIndex,
              );
              if (child == null) return const SizedBox.shrink();

              // 각 섹션을 VisibilityDetector로 래핑해 노출/체류를 측정
              return VisibilityDetector(
                key: ValueKey(
                  'article-${article.id}-${identityHashCode(this)}-section-$sectionIndex',
                ),
                onVisibilityChanged: (info) {
                  if (!mounted) return;
                  _handleSectionVisibility(
                    article,
                    section,
                    sectionIndex,
                    info.visibleFraction,
                  );
                },
                child: child,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHeader(ArticleDetail article, ArticleDetailViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (article.coverImage != null && article.coverImage!.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space20),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.button),
                child: Image.network(
                  viewModel.getAssetUrl(article.coverImage!),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.grey100,
                        borderRadius: BorderRadius.circular(AppRadius.button),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColors.grey400,
                          size: AppIconSize.lg,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],

        if (article.category.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space8, vertical: AppSpacing.space4),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                article.category,
                style: const TextStyle(fontSize: AppFontSize.sm, color: PRIMARY_COLOR),
              ),
            ),
          ),

        if (article.title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space16),
            child: Text(
              article.title,
              style: TextStyle(fontSize: AppFontSize.display, fontWeight: AppFontWeight.bold),
            ),
          ),

        if (article.subtitle.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space16),
            child: Text(
              article.subtitle,
              style: TextStyle(fontSize: AppFontSize.lg, color: AppColors.textSecondary),
            ),
          ),

        if (article.interviewee.isNotEmpty || article.publishedAt.isNotEmpty)
          Row(
            children: [
              if (article.interviewee.isNotEmpty)
                Text(
                  article.interviewee,
                  style: TextStyle(fontSize: AppFontSize.sm, color: AppColors.grey400),
                ),
              if (article.interviewee.isNotEmpty &&
                  article.publishedAt.isNotEmpty)
                SizedBox(width: AppSpacing.space12),
              if (article.publishedAt.isNotEmpty)
                Text(
                  DateUtilsHelper.toKoreanFormat(article.publishedAt),
                  style: TextStyle(fontSize: AppFontSize.sm, color: AppColors.grey400),
                ),
            ],
          ),
      ],
    );
  }

  /// 섹션 위젯을 생성한다. 추적 대상이 아니면(파싱 실패/빈 섹션) null 반환.
  Widget? _buildSectionChild(
    BuildContext context,
    ArticleDetailViewModel viewModel,
    ArticleDetail article,
    ArticleSection section,
    int sectionIndex,
  ) {
    if (section.item == null) return null;

    switch (section.collection) {
      case 'qa_section':
        try {
          final qaSection = QaSection.fromJson(section.item!);
          return QaSectionWidget(
            qaSection: qaSection,
            getAssetUrl: viewModel.getAssetUrl,
          );
        } catch (e) {
          debugPrint('QaSection 파싱 실패: $e');
          return null;
        }
      case 'purchase_link_section':
        try {
          final purchaseLinkSection = PurchaseLinkSection.fromJson(
            section.item!,
          );
          return PurchaseLinkSectionWidget(
            purchaseLinkSection: purchaseLinkSection,
            onPatternLinkClick: () {
              AnalyticsService.instance.logPatternLinkClick(
                article,
                viewModel.source,
                section,
                sectionIndex,
                buttonText: purchaseLinkSection.buttonText,
                buttonUrl: purchaseLinkSection.buttonUrl,
              );
            },
            onExternalPatternPageOpen: () {
              AnalyticsService.instance.logExternalPatternPageOpen(
                article,
                viewModel.source,
                buttonUrl: purchaseLinkSection.buttonUrl,
              );
            },
          );
        } catch (e) {
          debugPrint('PurchaseLinkSection 파싱 실패: $e');
          return null;
        }
      case 'note_section':
        try {
          final noteSection = NoteSection.fromJson(section.item!);
          return NoteSectionWidget(
            noteSection: noteSection,
            onArticleTap: (slugOrId) {
              AnalyticsService.instance.logNoteArticleLinkClick(
                article,
                viewModel.source,
                targetSlug: slugOrId,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  settings: const RouteSettings(name: 'article_detail'),
                  builder: (_) => ChangeNotifierProvider(
                    create: (_) => ArticleDetailViewModel(
                      context.read<ArticleRepository>(),
                      GetArticlePreviewsUseCase(
                        context.read<ProjectApiRepository>(),
                      ),
                      slugOrId: slugOrId,
                      source: 'note_link',
                    ),
                    child: const ArticleDetailScreen(),
                  ),
                ),
              );
            },
          );
        } catch (e) {
          debugPrint('NoteSection 파싱 실패: $e');
          return null;
        }
      case 'project_section':
        if (viewModel.state.articlePreviews.isEmpty) return null;
        try {
          final projectSection = ProjectSection.fromJson(section.item!);
          return ProjectSectionWidget(
            projectSection: projectSection,
            getArticlePreview: viewModel.getArticlePreview,
            onProjectTap: (projectId, position) async {
              // 카드 탭(작품 기록 보기) — LG2 opt-in 수요
              AnalyticsService.instance.logProjectCardClick(
                article,
                viewModel.source,
                section,
                sectionIndex,
                projectId: projectId,
                projectPosition: position,
              );
              // 복귀(article_return) 측정을 위한 push 상태 기록
              _pendingProjectId = projectId;
              _projectPushTime = DateTime.now();
              await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  settings: const RouteSettings(name: 'project_detail'),
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => ProjectDetailsViewModel(
                      GetProjectUseCase(context.read<ProjectApiRepository>()),
                      GetMyProjectUseCase(context.read<ProjectApiRepository>()),
                      DeleteProjectUseCase(context.read<ProjectApiRepository>()),
                      UpdateProjectUseCase(context.read<ProjectApiRepository>()),
                      GetRecordsProjectsUseCase(
                        context.read<RecordApiRepository>(),
                      ),
                      context.read<GetUserUseCase>(),
                      projectId: projectId,
                      source: 'article_detail',
                    ),
                    child: const ProjectDetailsScreen(),
                  ),
                ),
              );
            },
          );
        } catch (e) {
          debugPrint('ProjectSection 파싱 실패: $e');
          return null;
        }
      case 'pattern_section':
        try {
          final patternSection = PatternSection.fromJson(section.item!);
          return PatternSectionWidget(
            patternSection: patternSection,
            getAssetUrl: viewModel.getAssetUrl,
          );
        } catch (e) {
          debugPrint('PatternSection 파싱 실패: $e');
          return null;
        }
      default:
        return null;
    }
  }
}
