import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/widgets/knittda_app_bar.dart';
import 'package:knittda/src/presentation/widgets/knittda_empty_state.dart';
import 'package:knittda/src/presentation/widgets/knittda_loading.dart';
import 'package:knittda/src/domain/repository/announcement_repository.dart';
import 'package:knittda/src/presentation/announcement/announcement_view_model.dart';
import 'package:knittda/src/presentation/announcement/components/announcement_list_item.dart';
import 'package:knittda/src/presentation/announcement_detail/announcement_detail_screen.dart';
import 'package:knittda/src/presentation/announcement_detail/announcement_detail_view_model.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/core/theme/theme.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KnittdaAppBar(),
      body: Consumer<AnnouncementViewModel>(
        builder: (context, viewModel, _) {
          final state = viewModel.state;

          if (state.isLoading) {
            return const KnittdaLoadingView();
          }

          if (state.errorMessage != null) {
            return RefreshIndicator(
              onRefresh: () async {
                await viewModel.loadAnnouncement();
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(child: Text(state.errorMessage!)),
                  ),
                ],
              ),
            );
          }

          if (state.announcements.isEmpty) {
            return const KnittdaEmptyState(message: '등록된 공지가 없습니다');
          }

          return RefreshIndicator(
            onRefresh: () async {
              await viewModel.loadAnnouncement();
            },
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification &&
                    notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent - 200) {
                  viewModel.loadMore();
                }
                return false;
              },
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index == state.announcements.length) {
                    return const Padding(
                      padding: EdgeInsets.all(AppSpacing.space16),
                      child: KnittdaLoadingView(),
                    );
                  }

                  final announcement = state.announcements[index];
                  return InkWell(
                    onTap: () {
                      final slugOrId =
                          (announcement.slug?.trim().isEmpty ?? true)
                          ? announcement.id.toString()
                          : announcement.slug!;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          settings: const RouteSettings(name: 'announcement_detail'),
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => AnnouncementDetailViewModel(
                              context.read<AnnouncementRepository>(),
                              slugOrId: slugOrId,
                            ),
                            child: const AnnouncementDetailScreen(),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.space32,
                        vertical: AppSpacing.space12,
                      ),
                      child: AnnouncementListItem(announcement: announcement),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  if (index == state.announcements.length - 1 &&
                      state.hasMore) {
                    return const SizedBox.shrink();
                  }
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.space8),
                    child: Divider(height: 0.5, color: AppColors.grey200),
                  );
                },
                itemCount:
                    state.announcements.length + (state.isLoadingMore ? 1 : 0),
              ),
            ),
          );
        },
      ),
    );
  }
}
