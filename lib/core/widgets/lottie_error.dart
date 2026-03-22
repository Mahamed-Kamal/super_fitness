import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';

class LottieError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final double? width;
  final double? height;

  const LottieError({
    super.key,
    required this.message,
    required this.onRetry,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          AssetsManager.lottieError,
          width: width ?? 100,
          height: height ?? 100,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 10),
        Text(
          message,
          style: context.appTheme.medium16,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh_rounded, size: 20),
          label: Text('retry'.tr()),
        ),
      ],
    );
  }
}
