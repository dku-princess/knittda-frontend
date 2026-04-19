import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/domain/repository/article_repository.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';
import 'package:knittda/src/domain/use_case/get_article_previews_use_case.dart';
import 'package:knittda/src/domain/use_case/get_feed_use_case.dart';
import 'package:knittda/src/domain/use_case/get_project_previews_use_case.dart';
import 'package:knittda/src/domain/use_case/order_projects_use_case.dart';
import 'package:knittda/src/domain/use_case/get_user_use_case.dart';
import 'package:knittda/src/domain/use_case/logout_use_case.dart';
import 'package:knittda/src/domain/use_case/setting_profile_image_use_case.dart';
import 'package:knittda/src/domain/use_case/signout_use_case.dart';
import 'package:knittda/src/presentation/article_detail/article_detail_screen.dart';
import 'package:knittda/src/presentation/article_detail/article_detail_view_model.dart';
import 'package:knittda/src/presentation/article_list/article_list_screen.dart';
import 'package:knittda/src/presentation/article_list/article_list_view_model.dart';
import 'package:knittda/src/presentation/feed/feed_screen.dart';
import 'package:knittda/src/presentation/feed/feed_view_model.dart';
import 'package:knittda/src/presentation/home/components/bottom_banner_overlay.dart';
import 'package:knittda/src/presentation/home/home_view_model.dart';
import 'package:knittda/src/presentation/mypage/mypage_screen.dart';
import 'package:knittda/src/presentation/mypage/mypage_view_model.dart';
import 'package:knittda/src/presentation/project_previews/project_previews_screen.dart';
import 'package:knittda/src/presentation/project_previews/project_previews_view_model.dart';
import 'package:knittda/src/presentation/projects/projects_screen.dart';
import 'package:knittda/src/presentation/projects/projects_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// 바텀네비게이션 리스트
final List<BottomNavigationBarItem> myTabs = <BottomNavigationBarItem>[
  BottomNavigationBarItem(icon: Icon(Icons.article_outlined), label: '아티클'),
  BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: '홈'),
  BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: '작품'),
  BottomNavigationBarItem(icon: Icon(Icons.watch_later_outlined), label: '피드'),
  BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      ChangeNotifierProvider(
        create: (context) =>
            ArticleListViewModel(context.read<ArticleRepository>()),
        child: const ArticleListScreen(),
      ),
      ChangeNotifierProvider<ProjectsViewModel>(
        create: (context) => ProjectsViewModel(
          context.read<ProjectApiRepository>(),
          context.read<OrderProjectsUseCase>(),
        ),
        child: const ProjectsScreen(),
      ),

      ChangeNotifierProvider<ProjectPreviewsViewModel>(
        create: (context) =>
            ProjectPreviewsViewModel(context.read<GetProjectPreviewsUseCase>()),
        child: const ProjectPreviewsScreen(),
      ),

      ChangeNotifierProvider<FeedViewModel>(
        create: (context) => FeedViewModel(context.read<GetFeedUseCase>()),
        child: const FeedScreen(),
      ),

      ChangeNotifierProvider<MypageViewModel>(
        create: (context) => MypageViewModel(
          context.read<LogoutUseCase>(),
          context.read<SignoutUseCase>(),
          context.read<SettingProfileImageUseCase>(),
          context.read<GetUserUseCase>(),
        ),
        child: const MypageScreen(),
      ),
    ];

    return Consumer<HomeViewModel>(
      builder: (context, viewModel, _) {
        final banner = viewModel.state.currentBanner;

        return Stack(
          children: [
            Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: PRIMARY_COLOR,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                items: myTabs,
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
              body: IndexedStack(index: _selectedIndex, children: pages),
            ),

            if (banner != null)
              BottomBannerOverlay(
                banner: banner,
                imageUrl: banner.thumbnailImage != null
                    ? viewModel.getAssetUrl(banner.thumbnailImage!)
                    : null,
                onDismiss: (dismissType) {
                  viewModel.dismissBanner(dismissType);
                },
                onTapBanner: () async {
                  switch (banner.actionType) {
                    case 'none':
                      return;
                    case 'internal_route':
                      if (banner.targetType == 'article' &&
                          banner.targetId != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (context) => ArticleDetailViewModel(
                                context.read<ArticleRepository>(),
                                GetArticlePreviewsUseCase(
                                  context.read<ProjectApiRepository>(),
                                ),
                                slugOrId: banner.targetId.toString(),
                              ),
                              child: const ArticleDetailScreen(),
                            ),
                          ),
                        );
                      }
                    // TODO: notice
                    case 'external_url':
                      if (banner.externalUrl != null &&
                          banner.externalUrl!.isNotEmpty) {
                        try {
                          final uri = Uri.parse(banner.externalUrl!);
                          await launchUrl(
                            uri,
                            mode: LaunchMode.externalApplication,
                          );
                        } catch (e) {
                          debugPrint(
                            'Failed to launch URL: ${banner.externalUrl}, error: $e',
                          );
                        }
                      }
                  }
                },
              ),
          ],
        );
      },
    );
  }
}
