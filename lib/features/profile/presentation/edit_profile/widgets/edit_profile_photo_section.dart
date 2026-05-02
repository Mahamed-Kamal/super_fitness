import 'dart:io';

import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';

/// Avatar with local preview, network image loading/error handling, and
/// overlays for profile fetch and photo upload.
class EditProfilePhotoSection extends StatelessWidget {
  final File? localImage;
  final String profilePictureUrl;
  final bool isUploadingPhoto;

  /// First load of profile (no cached user in state yet).
  final bool isInitialProfileLoading;
  final VoidCallback onEditTap;

  const EditProfilePhotoSection({
    super.key,
    required this.localImage,
    required this.profilePictureUrl,
    required this.isUploadingPhoto,
    required this.isInitialProfileLoading,
    required this.onEditTap,
  });

  static const double _diameter = 116;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: _diameter,
        height: _diameter,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            ClipOval(
              child: SizedBox(
                width: _diameter,
                height: _diameter,
                child: ColoredBox(
                  color: Colors.white24,
                  child: _buildImageContent(context),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: (isUploadingPhoto || isInitialProfileLoading)
                      ? null
                      : onEditTap,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: context.appTheme.primary,
                    child: const Icon(
                      Icons.edit,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            if (isUploadingPhoto) _loadingOverlay(),
            if (isInitialProfileLoading && localImage == null)
              _loadingOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContent(BuildContext context) {
    if (localImage != null) {
      return Image.file(
        localImage!,
        fit: BoxFit.cover,
        width: _diameter,
        height: _diameter,
        errorBuilder: (_, _, _) => _placeholderIcon(context),
      );
    }
    if (profilePictureUrl.isEmpty) {
      return _placeholderIcon(context);
    }
    return Image.network(
      profilePictureUrl,
      fit: BoxFit.cover,
      width: _diameter,
      height: _diameter,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        final total = loadingProgress.expectedTotalBytes;
        final value = total != null && total > 0
            ? loadingProgress.cumulativeBytesLoaded / total
            : null;
        return Center(
          child: SizedBox(
            width: 36,
            height: 36,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              value: value,
              color: context.appTheme.primary,
            ),
          ),
        );
      },
      errorBuilder: (_, _, _) => _placeholderIcon(context),
    );
  }

  Widget _placeholderIcon(BuildContext context) {
    return Center(
      child: Icon(
        Icons.person_rounded,
        size: 58,
        color: context.appTheme.textMuted,
      ),
    );
  }

  Widget _loadingOverlay() {
    return Positioned.fill(
      child: ClipOval(
        child: ColoredBox(
          color: Colors.black54,
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
          ),
        ),
      ),
    );
  }
}
