import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/announcement/components/announcement_list_item.dart';
import 'package:knittda/src/presentation/announcement_detail/announcement_detail_view_model.dart';
import 'package:provider/provider.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  const AnnouncementDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<AnnouncementDetailViewModel>(
        builder: (context, viewModel, _) {
          final state = viewModel.state;
          final announcement = state.announcement;

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          }

          if (announcement == null) {
            return const Center(child: Text('공지를 찾을 수 없습니다'));
          }

          return ListView(
            children: [
              AnnouncementListItem(announcement: announcement),

              const SizedBox(height: 8),
              const Divider(height: 0.5, color: Color(0xFFE6E6E6)),
              const SizedBox(height: 8),

              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('테스트'),
              ),
            ],
          );
        },
      ),
    );
  }
}
