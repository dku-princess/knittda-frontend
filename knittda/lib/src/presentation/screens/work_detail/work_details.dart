import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/screens/work_detail/diary.dart';
import 'package:knittda/src/presentation/screens/work_detail/info.dart';
import 'package:knittda/src/presentation/screens/work_detail/report.dart';
import 'package:knittda/src/presentation/view_models/work_view_model.dart';
import 'package:knittda/src/presentation/widgets/image_box.dart';
import 'package:provider/provider.dart';

class WorkDetails extends StatefulWidget {
  final int projectId;

  const WorkDetails({super.key, required this.projectId});

  @override
  State<WorkDetails> createState() => _WorkDetailsState();
}

class _WorkDetailsState extends State<WorkDetails> with SingleTickerProviderStateMixin{
  bool _isLoading = true;
  late TabController _tabController;

  final List<Tab> tabs = <Tab>[
    Tab(text:'정보'),
    Tab(text:'다이어리'),
    Tab(text:'리포트'),
  ];

  final List<Widget> pages = [
    Info(),
    Diary(),
    Report(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    _getWork();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _getWork() async {
    try {
      final workViewModel = context.read<WorkViewModel>();
      await workViewModel.getWork(widget.projectId);
    } catch (e) {
      debugPrint('작품 불러오기 오류: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('작품 정보를 불러오는 데 실패했습니다.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final workViewModel = context.read<WorkViewModel>();
    final topPadding = MediaQuery.of(context).padding.top; //상태바 높이

    final work = workViewModel.work;

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (work == null) {
      return const Scaffold(
        body: Center(child: Text('작품 정보를 불러올 수 없습니다.')),
      );
    }

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        floatingActionButton: _tabController.index == 1
            ? FloatingActionButton(
          onPressed: () {

          },
          child: Icon(Icons.add),
        )
            : null,

        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true, //appbar 고정
                expandedHeight: 210.0, //확장 높이
                //backgroundColor: Colors.white, //배경 흰색
                leading: IconButton( //뒤로가기 버튼
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, color: Colors.black),
                    onSelected: (value) async {
                      if (value == 'edit') {
                        // 수정 동작
                      } else if (value == 'delete') {
                        // 삭제 확인 다이얼로그
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('작품 삭제'),
                            content: Text('정말 이 작품을 삭제하시겠습니까?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text('취소'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text('삭제', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );

                        if (confirmed == true) {
                          try {
                            final workViewModel = context.read<WorkViewModel>();
                            await workViewModel.deleteWork(widget.projectId);

                            if (context.mounted) {
                              Navigator.pop(context); // 삭제 후 상세 페이지 닫기
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('삭제 중 오류가 발생했습니다')),
                            );
                          }
                        }
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text('수정'),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text('삭제'),
                      ),
                    ],
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar( //확장영역
                  background: Padding(
                    padding: EdgeInsets.only(top: topPadding + 56, left: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageBox(null, size: 100),
                        SizedBox(width: 16),
                        Text(
                          workViewModel.work!.nickname,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                bottom: TabBar(
                  controller: _tabController,
                  tabs: tabs,
                  indicatorColor: Colors.black87, //tabbar 밑줄 색상
                  labelColor: Colors.black87, //선택된 영역 글자 색
                  unselectedLabelColor: Colors.grey, //선택 안된 영역 글자색
                ),
              ),
            ];
          },
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: pages,
          ),
        ),
      ),
    );
  }
}