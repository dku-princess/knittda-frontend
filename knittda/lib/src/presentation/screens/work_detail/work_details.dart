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

class _WorkDetailsState extends State<WorkDetails> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getWork();
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
                    onSelected: (value) {
                      if (value == 'edit') {
                        // 수정 동작
                      } else if (value == 'delete') {
                        // 삭제 동작
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text('수정'),
                        onTap: (){},
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text('삭제'),
                        onTap: (){},
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
                  tabs: tabs,
                  indicatorColor: Colors.black87, //tabbar 밑줄 색상
                  labelColor: Colors.black87, //선택된 영역 글자 색
                  unselectedLabelColor: Colors.grey, //선택 안된 영역 글자색
                ),
              ),
            ];
          },
          body: TabBarView(children: pages),
        ),
      ),
    );
  }
}