import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/feed/components/feed_item.dart';
import 'package:knittda/src/presentation/feed_search/feed_search_event.dart';
import 'package:knittda/src/presentation/feed_search/feed_search_ui_event.dart';
import 'package:knittda/src/presentation/feed_search/feed_search_view_model.dart';
import 'package:provider/provider.dart';

class FeedSearchScreen extends StatefulWidget {
  const FeedSearchScreen({super.key});

  @override
  State<FeedSearchScreen> createState() => _FeedSearchScreenState();
}

class _FeedSearchScreenState extends State<FeedSearchScreen> {
  final _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();

    final viewModel = context.read<FeedSearchViewModel>();
    _controller.text = viewModel.state.keyword;

    _scrollController.addListener(() {
      final viewModel = context.read<FeedSearchViewModel>();

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        // 검색어가 있을 때만 동작
        if (viewModel.state.keyword.isNotEmpty &&
            viewModel.state.hasMore &&
            !viewModel.state.isLoadingMore) {
          viewModel.onEvent(FeedSearchEvent.loadNext(20, null));
        }
      }
    });

    Future.microtask(() {
      if (mounted) {
        final viewModel = context.read<FeedSearchViewModel>();

        _subscription = viewModel.eventStream.listen((event) {
          switch (event) {
            case ShowSnackBar(:final message):
              if (mounted) {
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
    _controller.dispose();
    _scrollController.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  void _onSearch() {
    final keyword = _controller.text.trim();
    final viewModel = context.read<FeedSearchViewModel>();
    viewModel.onEvent(FeedSearchEvent.searchFeed(keyword, 0, 20, null));
  }

  void _onClear() {
    _controller.clear();
    final viewModel = context.read<FeedSearchViewModel>();
    viewModel.onEvent(const FeedSearchEvent.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: TextField(
          controller: _controller,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _onSearch(),
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
              onPressed: _onClear,
              icon: Icon(Icons.close),
            ),
          ),
        ),
      ),

      body: Consumer<FeedSearchViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.state.isLoading && viewModel.state.feeds.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("검색 하는 중..."),
                  SizedBox(height: 24),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }

          if (viewModel.state.feeds.isEmpty) {
            if (viewModel.state.keyword.isEmpty) {
              return const Center(child: Text('검색어를 입력해주세요'));
            }

            return Center(
              child: Text(
                '"${viewModel.state.keyword}" 에 대한 결과가 없습니다.',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (viewModel.state.isLoadingMore &&
                  index == viewModel.state.feeds.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return FeedItem(feed: viewModel.state.feeds[index], onTap: () {});
            },
            itemCount:
                viewModel.state.feeds.length +
                (viewModel.state.isLoadingMore ? 1 : 0),
          );
        },
      ),
    );
  }
}
