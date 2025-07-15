import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/feed_model.dart';
import 'package:knittda/src/data/repositories/feed_repository.dart';
import 'package:knittda/src/presentation/screens/feed/feed_search.dart';
import 'package:knittda/src/presentation/widgets/listitems/feed_list_item.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  late Future<List<FeedModel>> _future;
  final FeedRepository _repository = FeedRepository();

  @override
  void initState() {
    super.initState();
    _future = _fetchFeeds();
  }

  Future<List<FeedModel>> _fetchFeeds() {
    return _repository.fetchFeeds(
      page: 0,
      size: 10,
      sort: [],
    );
  }

  Future<void> _onRefresh() async {
    setState(() {
      _future = _fetchFeeds();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(left: 8.0, top: 8.0),
          child: Text(
            '피드',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedSearch(),
                ),
              );
            },
          ),
        ],
      ),

      body: FutureBuilder<List<FeedModel>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('에러: ${snapshot.error}'));
          }
          final feeds = snapshot.data!;
          if (feeds.isEmpty) {
            return const Center(child: Text('피드가 없습니다.'));
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 16, right: 24, left: 24, bottom: 8),
              itemCount: feeds.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final feed = feeds[index];
                return FeedListItem(feed: feed);
              },
            ),
          );
        },
      ),
    );
  }
}