import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/data/models/work_model.dart';
//import 'package:knittda/src/data/repositories/work_repository.dart';
//import 'package:knittda/src/domain/use_case/update_work_use_case.dart';
//import 'package:knittda/src/presentation/view_models/auth_view_model.dart';
import 'package:knittda/src/presentation/view_models/edit_work_view_model.dart';
//import 'package:provider/provider.dart';

class WorkStatusButton extends StatefulWidget {
  final WorkModel work;
  final EditWorkViewModel editVM;

  const WorkStatusButton({
    super.key,
    required this.work,
    required this.editVM,
  });

  @override
  State<WorkStatusButton> createState() => _WorkStatusButtonState();
}

class _WorkStatusButtonState extends State<WorkStatusButton> {
  late String _status;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _status = widget.work.status ?? 'IN_PROGRESS';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _toggleStatus() async {
    if (_isUpdating) return;
    final newStatus = _status == 'IN_PROGRESS' ? 'DONE' : 'IN_PROGRESS';

    setState(() => _isUpdating = true);

    final updatedWork = widget.work.copyWith(status: newStatus);
    final success = await widget.editVM.updateWork(updatedWork);

    setState(() => _isUpdating = false);

    if (success) {
      setState(() {
        _status = newStatus;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('상태 변경에 실패했습니다')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final label = _status == 'IN_PROGRESS' ? '뜨고 있어요' : '다 떴어요';

    return TextButton(
      onPressed: _toggleStatus,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // 둥근 정도 설정
          side: BorderSide(color: PRIMARY_COLOR),    // 테두리 색과 두께
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),

      child: Text(
        label,
        style: TextStyle(
          color: PRIMARY_COLOR,
        ),
      ),
    );
  }
}
