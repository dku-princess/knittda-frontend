import 'package:flutter/foundation.dart';
import 'package:knittda/src/data/models/feed_model.dart';
import 'package:knittda/src/domain/use_case/feed_service.dart';

class FeedSearchViewModel extends ChangeNotifier {
  final FeedService _service;
  final int _pageSize;

  FeedSearchViewModel(this._service, {int pageSize = 10})
      : _pageSize = pageSize;

  // ───── 상태
  final List<FeedModel> _feeds = [];
  bool _isLoading = false;
  bool _hasNext   = true;
  int  _page = 0;
  String? _error;
  String _keyword   = '';

  // ───── getters
  List<FeedModel> get feeds => List.unmodifiable(_feeds);
  bool get isLoading => _isLoading;
  bool get hasNext   => _hasNext;
  String? get error  => _error;
  String  get keyword  => _keyword;

  // ───── public
  Future<void> search(String query) async {
    _keyword = query.trim();
    if (_keyword.isEmpty) {
      _feeds.clear();
      notifyListeners();
      return;
    }
    _page = 0;
    _hasNext = true;
    _feeds.clear();
    await _load();
  }

  Future<void> loadMore() async {
    if (_isLoading || !_hasNext) return;
    _page += 1;
    await _load(append: true);
  }

  // ───── internal
  Future<void> _load({bool append = false}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newFeeds = await _service.searchFeeds(
        keyword: _keyword,
        page : _page,
        size : _pageSize,
      );

      if (append) {
        _feeds.addAll(newFeeds);
      } else {
        _feeds
          ..clear()
          ..addAll(newFeeds);
      }
      _hasNext = newFeeds.length == _pageSize;
    } catch (e, s) {
      debugPrintStack(label: 'Feed search error: $e', stackTrace: s);
      _error = '검색에 실패했습니다';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}