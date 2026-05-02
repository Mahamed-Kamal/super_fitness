import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';

class InstructionsSection extends StatefulWidget {
  final String text;

  const InstructionsSection({super.key, required this.text});

  @override
  State<InstructionsSection> createState() => _InstructionsSectionState();
}

class _InstructionsSectionState extends State<InstructionsSection> {
  bool _expanded = false;
  static const int _previewLength = 300;

  @override
  Widget build(BuildContext context) {
    final isLong = widget.text.length > _previewLength;
    final displayText = (!_expanded && isLong)
        ? '${widget.text.substring(0, _previewLength).trimRight()}…'
        : widget.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(displayText, style: TextStyle(fontSize: 16, height: 1.65)),
        if (isLong) ...[
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Text(
              _expanded ? 'show_less'.tr() : 'show_more'.tr(),
              style: TextStyle(
                color: context.appTheme.primary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
