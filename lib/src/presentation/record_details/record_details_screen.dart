import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/domain/model/images.dart';
import 'package:knittda/src/domain/model/records.dart';
import 'package:knittda/src/domain/repository/record_api_repository.dart';
import 'package:knittda/src/domain/use_case_record/add_record_use_case.dart';
import 'package:knittda/src/domain/use_case_record/get_question_use_case.dart';
import 'package:knittda/src/presentation/project_details/components/popup_menu_section.dart';
import 'package:knittda/src/presentation/record_add_edit/add_edit_record_screen.dart';
import 'package:knittda/src/presentation/record_add_edit/add_edit_record_view_model.dart';
import 'package:knittda/src/presentation/record_details/record_details_event.dart';
import 'package:knittda/src/presentation/record_details/record_details_ui_event.dart';
import 'package:knittda/src/presentation/record_details/record_details_view_model.dart';
import 'package:knittda/src/presentation/widgets/image_viewer.dart';
import 'package:provider/provider.dart';

import '../../domain/use_case_record/update_record_use_case.dart';

class RecordDetailsScreen extends StatefulWidget {
  const RecordDetailsScreen({super.key});

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
                Navigator.pop(context, true);
              case ShowSnackBar(:final message):
                final snackBar = SnackBar(content: Text(message));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        actions: [
          if (!state.isLoading)
            PopupMenuSection(
              onEdit: () async {
                final editedRecord = await Navigator.push<Records>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => AddEditRecordViewModel(
                        AddRecordUseCase(context.read<RecordApiRepository>()),
                        UpdateRecordUseCase(
                          context.read<RecordApiRepository>(),
                        ),
                        GetQuestionUseCase(context.read<RecordApiRepository>()),
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
                }
              },
              onDelete: () async {
                viewModel.onEvent(
                  RecordDetailsEvent.deleteRecord(recordId: state.record!.id!),
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
                  SizedBox(height: 24),
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
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //날짜 시간
                      Text(
                        '$dateStr $timeStr',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),

                      //기록
                      if (record.comment != null &&
                          record.comment!.isNotEmpty) ...[
                        Text(
                          record.comment!,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 40),
                      ],

                      //태그
                      if (record.tags != null && record.tags!.isNotEmpty) ...[
                        _RecordTags(tags: record.tags!),
                        const SizedBox(height: 16),
                      ],
                    ],
                  ),
                ),
              ],
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
          borderRadius: BorderRadius.circular(6),
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: Image.network(
              images.first.imageUrl,
              fit: BoxFit.cover,

              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              },

              errorBuilder: (context, exception, stackTrace) {
                return Container(
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                    size: 40,
                  ),
                );
              },
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
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                images[index].imageUrl,
                fit: BoxFit.cover,

                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                },

                errorBuilder: (context, exception, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 40,
                    ),
                  );
                },
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
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), // 완전 둥근 테두리
            border: Border.all(color: PRIMARY_COLOR, width: 1),
          ),
          child: Text(
            tag,
            style: const TextStyle(fontSize: 12, color: PRIMARY_COLOR),
          ),
        );
      }).toList(),
    );
  }
}
