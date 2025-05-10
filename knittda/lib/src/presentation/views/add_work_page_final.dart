import 'package:flutter/material.dart';
import 'package:knittda/src/constants/color.dart';

class AddWorkPageFinal extends StatefulWidget {
  @override
  _AddWorkPageState createState() => _AddWorkPageState();
}

class _AddWorkPageState extends State<AddWorkPageFinal> {
  final Map<String, TextEditingController> _controllers = {
    '작품 이름': TextEditingController(),
    '도안': TextEditingController(),
    '작가': TextEditingController(),
    '사이즈': TextEditingController(),
    '실': TextEditingController(),
    '실 사용량': TextEditingController(),
    '게이지': TextEditingController(),
    '바늘': TextEditingController(),
  };

  String _selectedDate = '목표 날짜';

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('작품 추가', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('기본 정보'),
              _buildWorkInfo(),
              SizedBox(height: 32),
              _buildSectionTitle('뜨개 정보'),
              _buildKnittingInfo(),
              SizedBox(height: 32),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Pretendard', fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildWorkInfo() {
    return Row(
      children: [
        Container(width: 110, height: 110, decoration: BoxDecoration(color: const Color(0xFFD9D9D9), borderRadius: BorderRadius.circular(4))),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(_controllers['작품 이름']!, '작품 이름'),
              SizedBox(height: 8),
              _buildDatePicker(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return SizedBox(
      width: 98,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFF0F0F0),
          foregroundColor: Color(0xFFA6A6A6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        onPressed: () async {
          DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            builder: (context, child) {
              return Theme(
                data: ThemeData(
                  colorScheme: ColorScheme.light(primary: PRIMARY_COLOR, onPrimary: Colors.white, surface: Colors.white),
                ),
                child: child!,
              );
            },
          );
          if (selectedDate != null) {
            setState(() {
              _selectedDate = "${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.day.toString().padLeft(2, '0')}";
            });
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_selectedDate, style: TextStyle(color: Color(0xFFA6A6A6), fontSize: 14)),
            SizedBox(width: 4),
            Icon(Icons.calendar_today, size: 16, color: Color(0xFFA6A6A6)),
          ],
        ),
      ),
    );
  }

  Widget _buildKnittingInfo() {
    return Column(
      children: _controllers.entries.map((entry) {
        return entry.key == '실 사용량' || entry.key == '게이지'
            ? Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Text(
                entry.key,
                style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Pretendard', fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 16),
              Expanded(child: _buildTextField(entry.value, entry.key)),
            ],
          ),
        )
            : Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Pretendard', fontWeight: FontWeight.w500),
              ),
              _buildTextField(entry.value, entry.key),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(color: const Color(0xFFF0F0F0), borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xFFA6A6A6), fontSize: 14),
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(14, 10, 14, 19),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: ShapeDecoration(
        color: const Color(0xFF0ABE8C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Center(
        child: Text(
          '작품 등록',
          style: TextStyle(color: const Color(0xFFFDFEFF), fontSize: 15, fontFamily: 'Pretendard', fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
