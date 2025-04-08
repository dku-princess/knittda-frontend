import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white, // 전체 배경색을 흰색으로 설정
      ),
      home: AddWorkPage(),
    );
  }
}

class AddWorkPage extends StatefulWidget {
  @override
  _AddWorkPageState createState() => _AddWorkPageState();
}

class _AddWorkPageState extends State<AddWorkPage> {
  // 텍스트 필드 컨트롤러
  final TextEditingController _designController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _yarnController = TextEditingController();
  final TextEditingController _yarnAmountController = TextEditingController();
  final TextEditingController _gaugeController = TextEditingController();
  final TextEditingController _needleController = TextEditingController();
  final TextEditingController _workNameController = TextEditingController(); // 작품 이름 컨트롤러 추가

  DateTime? _targetDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _targetDate) {
      setState(() {
        _targetDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('작품 추가'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '기본 정보',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Text('작품 이름을 지어 주세요.', style: TextStyle(fontSize: 16)),
              TextField(
                controller: _workNameController, // 작품 이름 컨트롤러 연결
                decoration: InputDecoration(
                  hintText: '작품의 이름을 작성해 주세요.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text('목표 날짜를 설정해 주세요.', style: TextStyle(fontSize: 16)),
              ElevatedButton(
                onPressed: () async {
                  await _selectDate(context);
                },
                child: Text(_targetDate == null
                    ? '날짜 선택'
                    : '선택된 날짜: ${_targetDate!.toLocal()}'),
              ),
              Divider(height: 40, color: Colors.grey),
              Text(
                '뜨개 정보',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Text('도안', style: TextStyle(fontSize: 16)),
              TextField(
                controller: _designController,
                decoration: InputDecoration(
                  hintText: '도안 정보를 입력해 주세요.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text('작가', style: TextStyle(fontSize: 16)),
              TextField(
                controller: _authorController,
                decoration: InputDecoration(
                  hintText: '작가 정보를 입력해 주세요.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text('사이즈', style: TextStyle(fontSize: 16)),
              TextField(
                controller: _sizeController,
                decoration: InputDecoration(
                  hintText: '사이즈 정보를 입력해 주세요.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text('실', style: TextStyle(fontSize: 16)),
              TextField(
                controller: _yarnController,
                decoration: InputDecoration(
                  hintText: '실 정보를 입력해 주세요.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text('실 사용량', style: TextStyle(fontSize: 16)),
              TextField(
                controller: _yarnAmountController,
                decoration: InputDecoration(
                  hintText: '실 사용량 정보를 입력해 주세요.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text('실 게이지', style: TextStyle(fontSize: 16)),
              TextField(
                controller: _gaugeController,
                decoration: InputDecoration(
                  hintText: '실 게이지 정보를 입력해 주세요.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text('바늘', style: TextStyle(fontSize: 16)),
              TextField(
                controller: _needleController,
                decoration: InputDecoration(
                  hintText: '바늘 정보를 입력해 주세요.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                '커버 이미지',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              // ... (나머지 커버 이미지 선택 UI)
              ElevatedButton(
                onPressed: () {
                  // 작품 등록 로직 (텍스트 필드 값 사용)
                  String workName = _workNameController.text;
                  String design = _designController.text;
                  String author = _authorController.text;
                  String size = _sizeController.text;
                  String yarn = _yarnController.text;
                  String yarnAmount = _yarnAmountController.text;
                  String gauge = _gaugeController.text;
                  String needle = _needleController.text;

                  print('작품 이름: $workName');
                  print('도안: $design');
                  print('작가: $author');
                  print('사이즈: $size');
                  print('실: $yarn');
                  print('실 사용량: $yarnAmount');
                  print('실 게이지: $gauge');
                  print('바늘: $needle');

                  // TODO: WorkList 파일에 추가하는 로직 구현

                  // 입력 필드 초기화
                  _designController.clear();
                  _authorController.clear();
                  _sizeController.clear();
                  _yarnController.clear();
                  _yarnAmountController.clear();
                  _gaugeController.clear();
                  _needleController.clear();
                  _workNameController.clear();
                  setState(() {
                    _targetDate = null;
                  });
                },
                child: Text('작품 등록'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0ABE8C),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



