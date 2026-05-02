import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';

class MealsAsyncLoading extends StatelessWidget {
  const MealsAsyncLoading({super.key, required this.messageKey});
  final String messageKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              messageKey.tr(),
              style: context.appTheme.regular14,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class MealsInfoMessage extends StatelessWidget {
  const MealsInfoMessage({super.key, required this.messageKey});
  final String messageKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(messageKey.tr(), style: context.appTheme.regular14),
      ),
    );
  }
}
