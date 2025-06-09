import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/view_models/search_view_model.dart';
import 'package:knittda/src/presentation/widgets/listitems/design_list_item.dart';
import 'package:provider/provider.dart';

class SearchPatterns extends StatefulWidget {
  const SearchPatterns({super.key});

  @override
  _SearchPatternsState createState() => _SearchPatternsState();
}

class _SearchPatternsState extends State<SearchPatterns> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce; // 디바운스 타이머

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    //0.5초 동안 추가 입력이 없으면 검색 실행
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final keyword = _searchController.text.trim();
      final viewModel = context.read<SearchViewModel>();

      if (keyword.isEmpty) {
        viewModel.reset(); // 검색어 지울 때 결과 초기화
      } else {
        viewModel.searchDesign(keyword);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('도안 검색', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            Expanded(child: _buildSearchResult()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: TextField(
          controller: _searchController,
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration(
            hintText: "검색",
            isDense: true,
            border: InputBorder.none,
          ),
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildSearchResult() {
    return Consumer<SearchViewModel>(
      builder: (context, viewModel, _) {
        final keyword = _searchController.text.trim();

        if (keyword.isEmpty) return const SizedBox();
        if (viewModel.isLoading) return const Center(child: CircularProgressIndicator());
        if (viewModel.errorMessage != null) {
          return Center(child: Text('에러 발생: ${viewModel.errorMessage}'));
        }

        final designs = viewModel.designs ?? [];
        if (designs.isEmpty) {
          return const Center(child: Text("검색 결과가 없습니다."));
        }

        return ListView.builder(
          itemCount: designs.length,
          itemBuilder: (context, index) {
            final design = designs[index];
            return DesignListItem(
              design: design,
              onTap: () {
                Navigator.pop(context, design);
              },
            );
          },
        );
      },
    );
  }

}
