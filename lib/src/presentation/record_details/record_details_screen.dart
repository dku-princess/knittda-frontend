import 'dart:async';

import 'package:flutter/material.dart';
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

    return PopScope<bool>(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop && viewModel.state.isChanged) {
          widget.onChanged?.call();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
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
                      horizontal: AppSpacing.space20,
                      vertical: AppSpacing.space20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //날짜 시간
                        Text(
                          '$dateStr $timeStr',
                          style: const TextStyle(
                            fontSize: AppFontSize.sm,
                            color: AppColors.grey400,
                          ),
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

class _RecordImages extends StatefulWidget {
  final List<Images> images;
  final void Function(int index, List<Images> images)? onImageTap;

  const _RecordImages({required this.images, this.onImageTap});

  @override
  State<_RecordImages> createState() => _RecordImagesState();
}

class _RecordImagesState extends State<_RecordImages> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1);
  }

  @override
  void didUpdateWidget(covariant _RecordImages oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 편집 등으로 이미지 목록이 바뀌면 인덱스/페이지를 처음으로 리셋
    // (기존 인덱스가 새 개수를 벗어나 인디케이터가 어긋나거나 범위를 벗어나는 문제 방지)
    if (oldWidget.images != widget.images) {
      _currentIndex = 0;
      if (_pageController.hasClients) {
        _pageController.jumpToPage(0);
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.images;
    final onImageTap = widget.onImageTap;

    // 기록 상세 이미지는 디자인 시스템의 둥근 모서리(ClipRRect) 적용 예외 —
    // 모서리 제거 결정(#124)을 유지하고, 색상만 디자인 토큰을 반영한다.
    if (images.length == 1) {
      return GestureDetector(
        onTap: () {
          onImageTap?.call(0, images);
        },
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
                color: AppColors.grey200,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.broken_image,
                  color: AppColors.grey400,
                  size: 40,
                ),
              );
            },
          ),
        ),
      );
    }

    // 여러 장일 경우
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onImageTap?.call(index, images);
                },
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
                      color: AppColors.grey200,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.broken_image,
                        color: AppColors.grey400,
                        size: 40,
                      ),
                    );
                  },
                ),
              );
            },
          ),

          // 페이지 인디케이터 (좌우 스와이프 가능 여부 안내)
          Positioned(
            left: 0,
            right: 0,
            bottom: 12,
            child: _PageIndicator(
              count: images.length,
              currentIndex: _currentIndex,
            ),
          ),
        ],
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const _PageIndicator({required this.count, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 8 : 6,
          height: isActive ? 8 : 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? Colors.white
                : Colors.white.withValues(alpha: 0.5),
          ),
        );
      }),
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
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space8, vertical: AppSpacing.space8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.pill), // 완전 둥근 테두리
            border: Border.all(color: PRIMARY_COLOR, width: 1),
          ),
          child: Text(
            tag,
            style: const TextStyle(fontSize: AppFontSize.sm, color: PRIMARY_COLOR),
          ),
        );
      }).toList(),
    );
  }
}
