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

          return ListView.separated(
            itemBuilder: (context, index) {
              final announcement = state.announcements[index];
              return AnnouncementListItem(
                announcement: announcement,
                onTap: (id, slug) {},
              );
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: const Divider(height: 0.5, color: Color(0xFFE6E6E6)),
              );
            },
            itemCount: state.announcements.length,
          );
        },
      ),
    );
  }
}
