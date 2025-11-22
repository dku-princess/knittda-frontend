import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/feed/components/feed_item.dart';
import 'package:knittda/src/presentation/feed/feed_event.dart';
import 'package:knittda/src/presentation/feed/feed_view_model.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final viewModel = context.read<FeedViewModel>();

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        if (viewModel.state.hasMore && !viewModel.state.isLoadingMore) {
          viewModel.onEvent(const FeedEvent.loadNext(20, null));
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          '피드',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),

      body: Consumer<FeedViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.state.isLoading && viewModel.state.feeds.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("피드 불러오는 중..."),
                  SizedBox(height: 24),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }

          if (viewModel.state.errorMessage != null &&
              viewModel.state.feeds.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await viewModel.onEvent(FeedEvent.refresh(20, null));
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [Center(child: Text(viewModel.state.errorMessage!))],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await viewModel.onEvent(FeedEvent.refresh(20, null));
            },
            child: ListView.separated(
              padding: const EdgeInsets.only(
                top: 4,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (viewModel.state.isLoadingMore &&
                    index == viewModel.state.feeds.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: FeedItem(feed: viewModel.state.feeds[index]),
                );
              },
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.grey[300]),
              itemCount:
                  viewModel.state.feeds.length +
                  (viewModel.state.isLoadingMore ? 1 : 0),
            ),
          );
        },
      ),
    );
  }
}
