import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/feed_model.dart';
import 'package:knittda/src/domain/use_case/feed_service.dart';

class FeedViewModel extends ChangeNotifier {
  final FeedService _service;
  final int _pageSize;

  FeedViewModel(this._service, {int pageSize = 10}) : _pageSize = pageSize;

  // ─────────────────────────────────────────── 상태
  final List<FeedModel> _feeds = [];
  bool _isLoading = false;
  bool _hasNext = true;
  int _page = 0;
  String? _error;

  // ─────────────────────────────────────────── getters
  List<FeedModel> get feeds => List.unmodifiable(_feeds);
  bool get isLoading => _isLoading;
  bool get hasNext => _hasNext;
  String? get error => _error;

  // ─────────────────────────────────────────── public API
  Future<void> loadInitial() async {
    _page = 0;
    _hasNext = true;
    _feeds.clear();
    await _load();
  }

  Future<void> loadMore() async {
    if (_isLoading || !_hasNext) return;

    _page += 1;
    final before = _feeds.length;

    await _load(append: true);

    if (_feeds.length == before) {
      _page -= 1;
    }
  }

  Future<void> refresh() => loadInitial();

  // ─────────────────────────────────────────── internal
  Future<void> _load({bool append = false}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newFeeds = await _service.getFeeds(
        page: _page,
        size: _pageSize,
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
      debugPrintStack(label: 'Feed load error: $e', stackTrace: s);
      _error = '피드를 불러오는 데 실패했습니다';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
