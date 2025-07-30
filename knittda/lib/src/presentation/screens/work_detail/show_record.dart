import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/domain/use_case/record_use_cases.dart';
import 'package:knittda/src/presentation/screens/work_detail/edit_record.dart';
import 'package:knittda/src/presentation/view_models/record_detail_view_model.dart';
import 'package:knittda/src/presentation/view_models/record_form_view_model.dart';
import 'package:knittda/src/presentation/view_models/record_list_view_model.dart';
import 'package:knittda/src/presentation/widgets/edit_delete_menu.dart';
import 'package:knittda/src/presentation/widgets/image_viewer_screen.dart';
import 'package:provider/provider.dart';

class ShowRecord extends StatefulWidget {
  final int recordId;
  final bool isOwner;

  const ShowRecord({
    super.key,
    required this.recordId,
    required this.isOwner,
  });

  @override
  State<ShowRecord> createState() => _ShowRecordState();
}

class _ShowRecordState extends State<ShowRecord> {
  late final PageController _pageCtrl;

  @override
  void initState() {
    super.initState();
    _pageCtrl = PageController();
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recordDetailVM = context.watch<RecordDetailViewModel>();
    final record = recordDetailVM.record;
    final error = recordDetailVM.error;
    final isBusy = recordDetailVM.isLoading;

    if (isBusy) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('에러 발생: $error')),
      );
    }

    if (record == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('기록을 불러올 수 없습니다.')),
      );
    }

    final corrected = record.createdAt!.add(const Duration(hours: 9));
    final dateStr = DateUtilsHelper.toDotFormat(corrected);
    final timeStr = DateUtilsHelper.toHourMinuteFormat(corrected);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            actions: widget.isOwner
                ? [
              EditDeleteMenu(
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider(
                        create: (_) => RecordFormViewModel(
                          useCases: context.read<RecordUseCases>(),
                          listViewModel: context.read<RecordListViewModel>(),
                          detailViewModel: context.read<RecordDetailViewModel>(),
                        ),
                        child: EditRecord(record: record),
                      ),
                    ),
                  );
                },
                onDelete: () async {
                  final success =  await context.read<RecordListViewModel>().remove(record.id!);

                  if (!context.mounted) return;

                  if (success) {
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('삭제 중 오류가 발생했습니다')),
                    );
                  }
                },
                deleteDialogTitle: '기록 삭제',
                deleteDialogContent: '정말 이 기록을 삭제하시겠습니까?',
              )
            ]
                : [],
          ),
          body: ListView(
            children: [
              //이미지
              if (record.images != null && record.images!.isNotEmpty) ...[
                AspectRatio(
                  aspectRatio: 3 / 2,
                  child: record.images!.length == 1
                      ? GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ImageViewerScreen(
                            imageUrls: record.images!.map((e) => e.imageUrl).toList(),
                            initialIndex: 0,
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        record.images!.first.imageUrl,
                        fit: BoxFit.cover,

                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                        },

                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade300,
                            alignment: Alignment.center,
                            child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
                          );
                        },

                      ),
                    ),
                  )
                      : PageView.builder(
                    key: PageStorageKey(record.id),
                    controller: _pageCtrl,
                    padEnds: false,
                    itemCount: record.images!.length,
                    itemBuilder: (context, index) {
                      final image = record.images![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ImageViewerScreen(
                                  imageUrls: record.images!.map((e) => e.imageUrl).toList(),
                                  initialIndex: index,
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child:Image.network(
                              image.imageUrl,
                              fit: BoxFit.cover,

                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                              },

                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade300,
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //시간
                    Row(
                      children: [
                        Text(dateStr, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        SizedBox(width: 10,),
                        Text(timeStr, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 26),

                    //comment
                    if (record.comment != null && record.comment!.isNotEmpty) ...[
                      Text(
                        record.comment ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 40),
                    ],

                    // 태그
                    if (record.tags != null && record.tags!.isNotEmpty) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: record.tags!.map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                border: Border.all(color: PRIMARY_COLOR),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  color: PRIMARY_COLOR,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        if (isBusy)
          const ColoredBox(
            color: Colors.black26,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}