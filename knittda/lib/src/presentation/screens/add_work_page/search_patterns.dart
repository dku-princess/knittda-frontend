import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/view_models/add_work_view_model.dart';
import 'package:knittda/src/presentation/view_models/search_view_model.dart';
import 'package:knittda/src/presentation/screens/add_work_page/add_work.dart';
import 'package:knittda/src/presentation/widgets/listitems/design_list_item.dart';
import 'package:provider/provider.dart';

class SearchPatterns extends StatefulWidget {
  const SearchPatterns({super.key});
  @override
  _SearchPatternsState createState() => _SearchPatternsState();
}

class _SearchPatternsState extends State<SearchPatterns> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce; // 🔹 디바운스 타이머

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final keyword = _searchController.text.trim();
      context.read<SearchViewModel>().search(keyword);
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
            Container(
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
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<SearchViewModel>(
                builder: (context, viewModel, _) {
                  if (viewModel.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (_searchController.text.isEmpty) {
                    return _buildInitialMessage(context);
                  }

                  if (viewModel.designs.isEmpty) {
                    return Center(child: Text("검색 결과가 없습니다."));
                  }

                  return ListView.builder(
                    itemCount: viewModel.designs.length,
                    itemBuilder: (context, index) {
                      final design = viewModel.designs[index];
                      return DesignListItem(
                        url: design.imageUrl,
                        title: design.title!,
                        designer: design.designer!,
                        onTap: (){
                          final addWorkVeiwModel = context.read<AddWorkViewModel>();
                          addWorkVeiwModel.setDesign(design);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider.value(
                                value: addWorkVeiwModel,
                                child: AddWorkPage(design: design),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialMessage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '도안을 선택하여 작품 정보 불러오기',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            '도안이 없으면\n작품 정보를 직접 입력할 수도 있어요',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[800], fontSize: 14),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 130,
            height: 44,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider.value(
                      value: context.read<AddWorkViewModel>(),
                      child: AddWorkPage(),
                    ),
                  ),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFE9F9F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "직접 입력하기",
                style: TextStyle(color: Color(0xFF00A367)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
