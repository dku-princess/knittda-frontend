import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/announcement/announcement_view_model.dart';
import 'package:knittda/src/presentation/announcement/components/announcement_list_item.dart';
import 'package:provider/provider.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<AnnouncementViewModel>(
        builder: (context, viewModel, _) {
          final state = viewModel.state;

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          }

          if (state.announcements.isEmpty) {
            return const Center(child: Text('등록된 공지가 없습니다'));
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
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final announcement = state.announcements[index];
                  return AnnouncementListItem(
                    announcement: announcement,
                    onTap: (id, slug) {},
                  );
                },
                separatorBuilder: (context, index) {
                  if (index == state.announcements.length - 1 &&
                      state.hasMore) {
                    return const SizedBox.shrink();
                  }
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(height: 0.5, color: Color(0xFFE6E6E6)),
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
