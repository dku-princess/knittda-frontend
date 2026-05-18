import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:knittda/src/core/utils/markdown_utils.dart';
import 'package:knittda/src/presentation/announcement/components/announcement_list_item.dart';
import 'package:knittda/src/presentation/announcement_detail/announcement_detail_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  const AnnouncementDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(scrolledUnderElevation: 0),
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: AnnouncementListItem(announcement: announcement),
              ),

              const SizedBox(height: 8),
              const Divider(height: 0.5, color: Color(0xFFE6E6E6)),
              const SizedBox(height: 32),

              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                child: MarkdownBody(
                  data: normalizeMarkdown(announcement.body),

                  onTapLink: (text, href, title) async {
                    if (href == null) return;
                    try {
                      final url = Uri.parse(href);
                      if (!await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      )) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('링크를 열 수 없습니다.')),
                          );
                        }
                      }
                    } catch (e) {
                      debugPrint('Failed to launch URL: $href, error: $e');
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('링크를 열 수 없습니다.')),
                        );
                      }
                    }
                  },

                  imageBuilder: (uri, title, alt) {
                    return Image.network(
                      uri.toString(),
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox.shrink(),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
