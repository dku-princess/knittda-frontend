import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/domain/use_case/work_use_cases.dart';
import 'package:knittda/src/presentation/view_models/work_list_view_model.dart';
import 'package:provider/provider.dart';

class WorkStatusButton extends StatefulWidget {
  final WorkModel work;
  final bool isOwner;

  const WorkStatusButton({
    super.key,
    required this.work,
    required this.isOwner,
  });

  @override
  State<WorkStatusButton> createState() => _WorkStatusButtonState();
}

class _WorkStatusButtonState extends State<WorkStatusButton> {
  late String _status;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _status = widget.work.status ?? 'IN_PROGRESS';
  }

  Future<void> _toggle() async {
    if (_busy || !widget.isOwner) return;

    final newStatus = _status == 'IN_PROGRESS' ? 'DONE' : 'IN_PROGRESS';

    setState(() => _busy = true);

    final update = widget.work.copyWith(
      status: newStatus,
      endDate: newStatus == 'DONE' ? DateTime.now() : null,
    );

    try {
      final useCases = context.read<WorkUseCases>();
      final updated = await useCases.updateWork(update);

      if (!mounted) return;

      // 전역 리스트 갱신
      context.read<WorkListViewModel>().insertOrReplace(updated);

      setState(() => _status = newStatus);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('상태 변경에 실패했습니다.')),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final label = _status == 'IN_PROGRESS' ? '뜨고 있어요' : '다 떴어요';

    return TextButton(
      onPressed: (!_busy && widget.isOwner) ? _toggle : null,
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
