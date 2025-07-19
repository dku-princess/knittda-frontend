import 'package:flutter/material.dart';
import 'package:knittda/src/domain/use_case/record_use_cases.dart';
import 'package:knittda/src/domain/use_case/work_use_cases.dart';
import 'package:knittda/src/presentation/screens/work_detail/show_work.dart';
import 'package:knittda/src/presentation/view_models/feed_search_view_model.dart';
import 'package:knittda/src/presentation/view_models/record_list_view_model.dart';
import 'package:knittda/src/presentation/view_models/work_detail_view_model.dart';
import 'package:knittda/src/presentation/widgets/listitems/feed_list_item.dart';
import 'package:provider/provider.dart';

class FeedSearch extends StatefulWidget {
  const FeedSearch({super.key});

  @override
  State<FeedSearch> createState() => _FeedSearchState();
}

class _FeedSearchState extends State<FeedSearch> {
  final _fieldController = TextEditingController();
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  void _onScroll() {
    final feedSearchVM = context.read<FeedSearchViewModel>();
    if (_scroll.position.pixels >=
        _scroll.position.maxScrollExtent - 200) {
      feedSearchVM.loadMore();
    }
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    _fieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: TextField(
            controller: _fieldController,
            textInputAction: TextInputAction.search,
            onSubmitted: context.read<FeedSearchViewModel>().search,
            decoration: InputDecoration(
              hintText: '검색',
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  _fieldController.clear();
                  context.read<FeedSearchViewModel>().search('');
                },
              ),
            ),
          ),
        ),
      ),

      body: Consumer<FeedSearchViewModel>(
        builder: (_, vm, __) {
          if (vm.isLoading && vm.feeds.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (vm.error != null && vm.feeds.isEmpty) {
            return Center(child: Text(vm.error!));
          }
          if (vm.feeds.isEmpty) {
            return const Center(child: Text('검색어를 입력하세요'));
          }

          return ListView.separated(
            controller: _scroll,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: vm.hasNext ? vm.feeds.length + 1 : vm.feeds.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
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
                  final workVM = WorkDetailViewModel(
                    context.read<WorkUseCases>(),
                  )..load(feed.projectId);

                  final recordVM = RecordListViewModel(
                    context.read<RecordUseCases>(),
                  )..refresh(feed.projectId);

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
          );
        },
      ),

    );
  }
}