import 'package:flutter/material.dart';
import 'package:knittda/src/domain/use_case/feed_service.dart';
import 'package:knittda/src/domain/use_case/record_use_cases.dart';
import 'package:knittda/src/domain/use_case/work_use_cases.dart';
import 'package:knittda/src/presentation/screens/feed/feed_search.dart';
import 'package:knittda/src/presentation/screens/work_detail/show_work.dart';
import 'package:knittda/src/presentation/view_models/feed_search_view_model.dart';
import 'package:knittda/src/presentation/view_models/feed_view_model.dart';
import 'package:knittda/src/presentation/view_models/record_list_view_model.dart';
import 'package:knittda/src/presentation/view_models/work_detail_view_model.dart';
import 'package:knittda/src/presentation/widgets/listitems/feed_list_item.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/presentation/widgets/image_viewer_screen.dart';


class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();

    // 첫 프레임이 그려진 뒤에 ViewModel 초기 로딩
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FeedViewModel>().loadInitial();
    });

    _scroll.addListener(_onScroll);
  }

  void _onScroll() {
    final feedVM = context.read<FeedViewModel>();
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200) {
      feedVM.loadMore();
    }
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 8.0, top: 8.0),
          child: Text(
            '피드',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (_) => FeedSearchViewModel(context.read<FeedService>()),
                      child: const FeedSearch(),
                    ),
                  ),
                );
              }
          ),
        ],
      ),

      body: Consumer<FeedViewModel>(
        builder: (_, vm, __) {
          if (vm.isLoading && vm.feeds.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (vm.error != null && vm.feeds.isEmpty) {
            return Center(child: Text(vm.error!));
          }

          return RefreshIndicator(
            onRefresh: vm.refresh,
            child: ListView.separated(
              controller: _scroll,
              //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: vm.hasNext ? vm.feeds.length + 1 : vm.feeds.length,
              separatorBuilder: (_, __) => const SizedBox.shrink(),
              itemBuilder: (_, index) {
                if (index == vm.feeds.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final feed = vm.feeds[index];
                return FeedListItem(
                  feed: feed,
                  onTap: () {
                    final workVM = WorkDetailViewModel(context.read<WorkUseCases>())
                      ..load(feed.projectId);
                    final recordVM = RecordListViewModel(context.read<RecordUseCases>())
                      ..refresh(feed.projectId);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MultiProvider(
                          providers: [
                            ChangeNotifierProvider.value(value: workVM),
                            ChangeNotifierProvider.value(value: recordVM),
                          ],
                          child: ShowWork(projectId: feed.projectId),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}