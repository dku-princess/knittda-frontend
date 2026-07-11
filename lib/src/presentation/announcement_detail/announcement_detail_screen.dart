import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/widgets/knittda_snack_bar.dart';
import 'package:knittda/src/presentation/widgets/knittda_app_bar.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:knittda/src/core/utils/markdown_utils.dart';
import 'package:knittda/src/presentation/announcement/components/announcement_list_item.dart';
import 'package:knittda/src/presentation/announcement_detail/announcement_detail_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:knittda/src/core/theme/theme.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  const AnnouncementDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KnittdaAppBar(),
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
                  horizontal: AppSpacing.space20,
                  vertical: AppSpacing.space12,
                ),
                child: AnnouncementListItem(announcement: announcement),
              ),

              const SizedBox(height: AppSpacing.space8),
              const Divider(height: 0.5, color: AppColors.grey200),
              const SizedBox(height: AppSpacing.space32),

              Padding(
                padding: const EdgeInsets.only(left: AppSpacing.space20, right: AppSpacing.space20, bottom: AppSpacing.space40),
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
                          KnittdaSnackBar.show(context, '링크를 열 수 없습니다.', tone: KnittdaSnackTone.error);
                        }
                      }
                    } catch (e) {
                      debugPrint('Failed to launch URL: $href, error: $e');
                      if (context.mounted) {
                        KnittdaSnackBar.show(context, '링크를 열 수 없습니다.', tone: KnittdaSnackTone.error);
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
