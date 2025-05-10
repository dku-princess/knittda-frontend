import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/screens/add_work_page_final.dart';
import 'package:knittda/src/presentation/widgets/listitems/design_list_item.dart';


class AddWorkPage extends StatefulWidget {
  @override
  _AddWorkPageState createState() => _AddWorkPageState();
}

class _AddWorkPageState extends State<AddWorkPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Widget> worklist = <Widget>[
    DesignListItem(url: null, name: "벤쿠버 가디건"),
    DesignListItem(url: null, name: "블랙베리 아란 스웨터"),
    DesignListItem(url: null, name: "브이넥 조끼"),
    DesignListItem(url: null, name: "브이넥 조끼"),
    DesignListItem(url: null, name: "브이넥 조끼"),
    DesignListItem(url: null, name: "브이넥 조끼")
  ];

  List<Widget> filteredList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      if (_searchController.text.isEmpty) {
        filteredList = [];
      } else {
        filteredList = worklist.where((item) {
          if (item is DesignListItem) {
            return item.name.toLowerCase().contains(_searchController.text.toLowerCase());
          }
          return false;
        }).toList();
      }
    });
  }

  @override
  void dispose() {
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
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: '검색',
                  hintStyle: TextStyle(color: Color(0xFFA6A6A6), fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(14, 10, 14, 19),
                ),
              ),
            ),
            const SizedBox(height: 30),

            if (_searchController.text.isEmpty) ...[
              const Text(
                '도안을 선택하여 작품 정보 불러오기',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              const Text(
                '도안이 없으면\n작품 정보를 직접 입력할 수도 있어요',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF4D4D4D), fontSize: 14),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFFE9F9F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddWorkPageFinal()),
                  );
                },
                child: const Text(
                  '직접 입력하기',
                  style: TextStyle(color: Color(0xFF00A367), fontSize: 16),
                ),
              ),
            ],

            if (filteredList.isNotEmpty)
              Expanded(
                child: ListView(
                  children: filteredList,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

