import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/model/records.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';
import 'package:knittda/src/domain/repository/record_api_repository.dart';
import 'package:knittda/src/domain/use_case/add_project_use_case.dart';
import 'package:knittda/src/domain/use_case/update_project_use_case.dart';
import 'package:knittda/src/domain/use_case/add_record_use_case.dart';
import 'package:knittda/src/domain/use_case/delete_record_use_case.dart';
import 'package:knittda/src/domain/use_case/get_question_use_case.dart';
import 'package:knittda/src/domain/use_case/get_record_use_case.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_screen.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_view_model.dart';
import 'package:knittda/src/presentation/project_details/components/popup_menu_section.dart';
import 'package:knittda/src/presentation/project_details/components/progress_section.dart';
import 'package:knittda/src/presentation/project_details/components/record_item.dart';
import 'package:knittda/src/presentation/project_details/diary_tap_state.dart';
import 'package:knittda/src/presentation/project_details/project_details_event.dart';
import 'package:knittda/src/presentation/project_details/project_details_ui_event.dart';
import 'package:knittda/src/presentation/project_details/project_details_view_model.dart';
import 'package:knittda/src/presentation/record_add_edit/add_edit_record_screen.dart';
import 'package:knittda/src/presentation/record_add_edit/add_edit_record_view_model.dart';
import 'package:knittda/src/presentation/record_details/record_details_screen.dart';
import 'package:knittda/src/presentation/record_details/record_details_view_model.dart';
import 'package:knittda/src/presentation/widgets/image_viewer.dart';
import 'package:provider/provider.dart';

import '../../domain/use_case/update_record_use_case.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({super.key});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  StreamSubscription? _subscription;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        final viewModel = context.read<ProjectDetailsViewModel>();

        _subscription = viewModel.eventStream.listen((event) {
          if (mounted) {
            switch (event) {
              case DeletedProject():
                Navigator.pop(context, true);
              case ShowSnackBar(:final message):
                final snackBar = SnackBar(content: Text(message));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              case NotFound():
                Navigator.pop(context, false);
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProjectDetailsViewModel>();
    final state = viewModel.state;

    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Builder(
        builder: (context) {
          final tabController = DefaultTabController.of(context);

          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              actions: [
                if (!state.isLoading && state.project != null && state.isOwner)
                  PopupMenuSection(
                    onEdit: () async {
                      final editedProject = await Navigator.push<Project>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => AddEditProjectViewModel(
                              AddProjectUseCase(
                                context.read<ProjectApiRepository>(),
                              ),
                              UpdateProjectUseCase(
                                context.read<ProjectApiRepository>(),
                              ),
                            ),
                            child: AddEditProjectScreen(
                              project: state.project!,
                            ),
                          ),
                        ),
                      );

                      if (editedProject != null) {
                        viewModel.onEvent(
                          ProjectDetailsEvent.loadProject(
                            projectId: state.project!.id!,
                            project: editedProject,
                          ),
                        );
                      }
                    },
                    onDelete: () async {
                      viewModel.onEvent(
                        ProjectDetailsEvent.deleteProject(
                          projectId: state.project!.id!,
                        ),
                      );
                    },
                  ),
              ],
            ),

            floatingActionButton: AnimatedBuilder(
              animation: tabController,
              builder: (context, _) {
                return (state.project != null &&
                        tabController.index == 1 &&
                        state.isOwner)
                    ? FloatingActionButton(
                        onPressed: () async {
                          final addRecord = await Navigator.push<Records>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                create: (context) => AddEditRecordViewModel(
                                  AddRecordUseCase(
                                    context.read<RecordApiRepository>(),
                                  ),
                                  UpdateRecordUseCase(
                                    context.read<RecordApiRepository>(),
                                  ),
                                  GetQuestionUseCase(
                                    context.read<RecordApiRepository>(),
                                  ),
                                  projectId: state.project!.id!,
                                ),
                                child: AddEditRecordScreen(
                                  projectId: state.project!.id!,
                                ),
                              ),
                            ),
                          );

                          if (addRecord != null) {
                            viewModel.onEvent(
                              ProjectDetailsEvent.loadRecords(
                                projectId: state.project!.id!,
                              ),
                            );
                            viewModel.onEvent(
                              ProjectDetailsEvent.loadProject(
                                projectId: state.project!.id!,
                                project: state.project,
                              ),
                            );
                          }
                        },
                        backgroundColor: PRIMARY_COLOR,
                        child: const Icon(Icons.add, color: Colors.white),
                      )
                    : const SizedBox.shrink();
              },
            ),

            body: state.isLoading
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("작품 불러오는 중..."),
                        SizedBox(height: 24),
                        CircularProgressIndicator(),
                      ],
                    ),
                  )
                : state.project == null
                ? const Center(child: Text("작품 정보를 불러오지 못했어요."))
                : NestedScrollView(
                    controller: _scrollController,
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverToBoxAdapter(
                          child: _ProjectHeader(
                            project: state.project!,
                            isOwner: state.isOwner,
                            onProgressPressed: () {
                              viewModel.onEvent(
                                ProjectDetailsEvent.changeProgress(),
                              );
                            },
                          ),
                        ),

                        SliverPersistentHeader(
                          pinned: true,
                          delegate: _TabBarDelegate(
                            tabBar: TabBar(
                              onTap: (_) => _scrollToTop(),
                              tabs: [
                                Tab(text: '정보'),
                                Tab(text: '다이어리'),
                                Tab(text: '리포트'),
                              ],
                            ),
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _InfoTap(project: state.project!),
                        _DiaryTap(
                          state: state.diaryTapState,
                          onRecordTap: (record) async {
                            bool? isChanged = await Navigator.push<bool>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                  create: (context) => RecordDetailsViewModel(
                                    GetRecordUseCase(
                                      context.read<RecordApiRepository>(),
                                    ),
                                    DeleteRecordUseCase(
                                      context.read<RecordApiRepository>(),
                                    ),
                                    recordId: record.id!,
                                    record: record,
                                    isOwner: state.isOwner,
                                  ),
                                  child: const RecordDetailsScreen(),
                                ),
                              ),
                            );

                            if (isChanged == true) {
                              viewModel.onEvent(
                                ProjectDetailsEvent.loadRecords(
                                  projectId: state.project!.id!,
                                ),
                              );

                              viewModel.onEvent(
                                ProjectDetailsEvent.loadProject(
                                  projectId: state.project!.id!,
                                  project: state.project,
                                ),
                              );
                            }
                          },
                        ),
                        _ReportTap(
                          project: state.project!,
                          record: state.diaryTapState.records.isNotEmpty
                              ? state.diaryTapState.records.first
                              : null,
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  const _TabBarDelegate({required this.tabBar});

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) {
    return oldDelegate.tabBar != tabBar;
  }
}

class _ProjectHeader extends StatelessWidget {
  final Project project;
  final VoidCallback onProgressPressed;
  final bool isOwner;

  const _ProjectHeader({
    required this.project,
    required this.onProgressPressed,
    required this.isOwner,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 20, left: 20, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 작품 대표 사진
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child:
                (project.thumbnailUrl != null &&
                    project.thumbnailUrl!.isNotEmpty)
                ? Image.network(
                    project.thumbnailUrl!,
                    width: 115,
                    height: 115,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 115,
                        height: 115,
                        color: Colors.grey[300],
                        child: Icon(Icons.broken_image, color: Colors.grey),
                      );
                    },
                  )
                : Container(
                    width: 115,
                    height: 115,
                    color: Colors.grey[300],
                    child: Icon(Icons.image_outlined, color: Colors.grey),
                  ),
          ),

          SizedBox(width: 26),

          //작품 이름, 작품 상태 버튼
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.nickname, style: TextStyle(fontSize: 20)),

                SizedBox(height: 16),

                if (isOwner)
                  ProgressSection(
                    status: project.status!,
                    onPressed: onProgressPressed,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTap extends StatelessWidget {
  final Project project;

  const _InfoTap({required this.project});

  Widget _infoRow(String label, String? value) {
    final isEmpty = value == null || value.isEmpty;

    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(label, style: const TextStyle(fontSize: 16)),
        ),
        Expanded(
          child: Text(
            isEmpty ? '-' : value,
            style: TextStyle(fontSize: 16, color: isEmpty ? Colors.grey : null),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),

      children: [
        _infoRow('도안', project.design?.title),
        SizedBox(height: 20),

        _infoRow('작가', project.design?.designer),
        SizedBox(height: 20),

        _infoRow('실', project.design?.yarnInfo),
        SizedBox(height: 20),

        _infoRow('바늘', project.design?.needleInfo),
        SizedBox(height: 20),
      ],
    );
  }
}

class _DiaryTap extends StatelessWidget {
  final DiaryTapState state;
  final Future<void> Function(Records record) onRecordTap;

  const _DiaryTap({required this.state, required this.onRecordTap});

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.records.isEmpty) {
      return const Center(child: Text('기록을 작성해 주세요.'));
    }

    if (state.errorMessage != null) {
      return Center(child: Text(state.errorMessage!));
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: state.records.length,
      itemBuilder: (context, index) {
        return RecordItem(
          record: state.records[index],
          onTap: () {
            onRecordTap(state.records[index]);
          },
          onImageTap: (imageIndex, images) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    ImageViewer(images: images, initialIndex: imageIndex),
              ),
            );
          },
        );
      },
    );
  }
}

class _ReportTap extends StatelessWidget {
  final Project project;
  final Records? record;

  const _ReportTap({required this.project, required this.record});

  int _statusPercent(Records? record) {
    if (record == null) return 0;

    switch (record.recordStatus) {
      case 'NOT_STARTED':
        return 0;
      case 'STARTED':
        return 25;
      case 'IN_PROGRESS':
        return 50;
      case 'ALMOST_DONE':
        return 75;
      case 'COMPLETED':
        return 100;
    }
    return 0;
  }

  DateTime? _parseDate(String? value) {
    if (value == null || value.isEmpty) return null;
    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final percent = _statusPercent(record);

    final now = DateTime.now();
    final startDate = _parseDate(project.startDate);
    final goalDate = _parseDate(project.goalDate);

    String dPlusText = 'D + ';
    String dMinusText = 'D - ';

    if (startDate != null) {
      final diff = now.difference(startDate).inDays;
      dPlusText = 'D + $diff';
    }

    if (goalDate != null) {
      final diff = goalDate.difference(now).inDays;
      if (diff == 0) {
        dMinusText = 'D - day';
      } else if (diff > 0) {
        dMinusText = 'D - $diff';
      } else {
        dMinusText = 'D + ${diff.abs()}';
      }
    }

    final startDateText = startDate != null
        ? DateUtilsHelper.toDotFormat(startDate)
        : '시작일 정보 없음';

    final goalDateText = goalDate != null
        ? DateUtilsHelper.toDotFormat(goalDate)
        : '목표일 정보 없음';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "나의 진행도",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),

          SizedBox(height: 26),

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 130,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        Container(color: Colors.grey[200]),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: FractionallySizedBox(
                            heightFactor: percent / 100,
                            widthFactor: 1.0,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [PRIMARY_COLOR, Color(0xFFEEEEEE)],
                                ),
                              ),
                            ),
                          ),
                        ),

                        Center(
                          child: Text(
                            '$percent%',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: PRIMARY_COLOR,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 26),

              Expanded(
                child: Container(
                  height: 130,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dPlusText,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: PRIMARY_COLOR,
                        ),
                      ),
                      Text(
                        startDateText,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        dMinusText,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: PRIMARY_COLOR,
                        ),
                      ),
                      Text(
                        goalDateText,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
