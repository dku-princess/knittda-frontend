import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/widgets/knittda_snack_bar.dart';
import 'package:knittda/src/presentation/widgets/knittda_app_bar.dart';
import 'package:knittda/src/presentation/widgets/knittda_network_image.dart';
import 'package:knittda/src/presentation/widgets/knittda_tag.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/domain/model/images.dart';
import 'package:knittda/src/domain/model/records.dart';
import 'package:knittda/src/domain/repository/record_api_repository.dart';
import 'package:knittda/src/domain/use_case/add_record_use_case.dart';
import 'package:knittda/src/domain/use_case/get_question_use_case.dart';
import 'package:knittda/src/presentation/project_details/components/popup_menu_section.dart';
import 'package:knittda/src/presentation/record_add_edit/add_edit_record_screen.dart';
import 'package:knittda/src/presentation/record_add_edit/add_edit_record_view_model.dart';
import 'package:knittda/src/presentation/record_details/record_details_event.dart';
import 'package:knittda/src/presentation/record_details/record_details_ui_event.dart';
import 'package:knittda/src/presentation/record_details/record_details_view_model.dart';
import 'package:knittda/src/presentation/widgets/image_viewer.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/core/theme/theme.dart';

import '../../domain/use_case/update_record_use_case.dart';

class RecordDetailsScreen extends StatefulWidget {
  final VoidCallback? onChanged;

  const RecordDetailsScreen({super.key, this.onChanged});

  @override
  State<RecordDetailsScreen> createState() => _RecordDetailsScreenState();
}

class _RecordDetailsScreenState extends State<RecordDetailsScreen> {
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        final viewModel = context.read<RecordDetailsViewModel>();

        _subscription = viewModel.eventStream.listen((event) {
          if (mounted) {
            switch (event) {
              case DeletedRecord():
                Navigator.pop(context);
              case ShowSnackBar(:final message):
                KnittdaSnackBar.show(context, message);
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RecordDetailsViewModel>();
    final state = viewModel.state;
    final record = state.record!;

    final dateStr = DateUtilsHelper.toDotFormat(record.createdAt!);
    final timeStr = DateUtilsHelper.toHourMinuteFormat(record.createdAt!);

    return PopScope<bool>(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop && viewModel.state.isChanged) {
          widget.onChanged?.call();
        }
      },
      child: Scaffold(
        appBar: KnittdaAppBar(
          actions: [
            if (!state.isLoading && state.isOwner)
              PopupMenuSection(
                onEdit: () async {
                  final editedRecord = await Navigator.push<Records>(
                    context,
                    MaterialPageRoute(
                      settings: const RouteSettings(name: 'record_edit'),
                      builder: (context) => ChangeNotifierProvider(
                        create: (context) => AddEditRecordViewModel(
                          AddRecordUseCase(context.read<RecordApiRepository>()),
                          UpdateRecordUseCase(
                            context.read<RecordApiRepository>(),
                          ),
                          GetQuestionUseCase(
                            context.read<RecordApiRepository>(),
                          ),
                          projectId: record.projectId,
                        ),
                        child: AddEditRecordScreen(
                          projectId: record.projectId,
                          record: record,
                        ),
                      ),
                    ),
                  );

                  if (editedRecord != null) {
                    viewModel.onEvent(
                      RecordDetailsEvent.loadRecord(
                        recordId: record.id!,
                        record: editedRecord,
                      ),
                    );

                    viewModel.onEvent(RecordDetailsEvent.markChanged());
                  }
                },
                onDelete: () async {
                  viewModel.onEvent(
                    RecordDetailsEvent.deleteRecord(
                      recordId: state.record!.id!,
                    ),
                  );
                },
              ),
          ],
        ),

        body: state.isLoading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("기록 불러오는 중..."),
                    SizedBox(height: AppSpacing.space24),
                    CircularProgressIndicator(),
                  ],
                ),
              )
            : ListView(
                children: [
                  //이미지
                  if (record.images != null && record.images!.isNotEmpty) ...[
                    _RecordImages(
                      images: record.images!,
                      onImageTap: (imageIndex, images) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ImageViewer(
                              images: images,
                              initialIndex: imageIndex,
                            ),
                          ),
                        );
                      },
                    ),
                  ],

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppLayout.screenPaddingH,
                      vertical: AppSpacing.space20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //날짜 시간
                        Text(
                          '$dateStr $timeStr',
                          style: AppTextStyles.caption,
                        ),
                        const SizedBox(height: AppSpacing.space20),

                        //기록
                        if (record.comment != null &&
                            record.comment!.isNotEmpty) ...[
                          Text(
                            record.comment!,
                            style: const TextStyle(fontSize: AppFontSize.lg),
                          ),
                          const SizedBox(height: AppSpacing.space40),
                        ],

                        //태그
                        if (record.tags != null && record.tags!.isNotEmpty) ...[
                          _RecordTags(tags: record.tags!),
                          const SizedBox(height: AppSpacing.space16),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _RecordImages extends StatelessWidget {
  final List<Images> images;
  final void Function(int index, List<Images> images)? onImageTap;

  const _RecordImages({required this.images, this.onImageTap});

  @override
  Widget build(BuildContext context) {
    if (images.length == 1) {
      return GestureDetector(
        onTap: () {
          onImageTap?.call(0, images);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.chip),
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: KnittdaNetworkImage(
              url: images.first.imageUrl,
              placeholderIcon: Icons.broken_image,
            ),
          ),
        ),
      );
    }

    // 여러 장일 경우
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: PageView.builder(
        controller: PageController(viewportFraction: 1),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onImageTap?.call(index, images);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.card),
              child: KnittdaNetworkImage(
                url: images[index].imageUrl,
                placeholderIcon: Icons.broken_image,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RecordTags extends StatelessWidget {
  final List<String> tags;
  const _RecordTags({required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8, // 태그 사이 가로 간격
      runSpacing: 10, // 줄 바뀔 때 세로 간격
      children: tags.map((tag) {
        return KnittdaTag(label: tag);
      }).toList(),
    );
  }
}
