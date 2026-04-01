import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';

class CustomDataPicker extends StatefulWidget {
  final String title;
  final String subtitle;
  final String unit;
  final int minValue;
  final int maxValue;
  final int initialValue;
  final ValueChanged<int> onValueChanged;
  final VoidCallback onNext;

  const CustomDataPicker({
    super.key,
    required this.title,
    required this.subtitle,
    required this.unit,
    required this.minValue,
    required this.maxValue,
    required this.initialValue,
    required this.onValueChanged,
    required this.onNext,
  });

  @override
  State<CustomDataPicker> createState() => _CustomDataPickerState();
}

class _CustomDataPickerState extends State<CustomDataPicker> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title.toUpperCase(),
                  style: context.appTheme.semiBold24,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.subtitle,
                  style: context.appTheme.regular14.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),

          GlassContainer(
            child: Column(
              children: [
                Text(
                  widget.unit,
                  style: TextStyle(
                    color: context.appTheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 15),

                NumberPicker(
                  value: _currentValue,
                  minValue: widget.minValue,
                  maxValue: widget.maxValue,
                  step: 1,
                  itemHeight: 62,
                  itemWidth: 69,
                  itemCount: 5,
                  axis: Axis.horizontal,
                  onChanged: (value) {
                    setState(() => _currentValue = value);
                    widget.onValueChanged(value);
                  },
                  selectedTextStyle: context.appTheme.semiBold24.copyWith(
                    fontSize: 45,
                    color: context.appTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  textStyle: context.appTheme.semiBold24.copyWith(
                    fontSize: 25,
                    color: context.appTheme.textMuted,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Icon(
                  Icons.arrow_drop_up_sharp,
                  size: 35,
                  color: context.appTheme.primary,
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: widget.onNext,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),
                  ),
                  child: const Text("NEXT"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
