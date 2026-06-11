import 'package:flutter/material.dart';

import '../../tokens/app_radii.dart';
import '../../tokens/app_spacing.dart';
import 'app_card.dart';

class AppImageCard extends StatelessWidget {
  const AppImageCard({
    super.key,
    this.image,
    this.imageHeight = 180,
    this.content,
    this.overlay,
    this.onTap,
    this.borderRadius = AppRadii.lg,
  });

  final ImageProvider? image;
  final double imageHeight;

  final Widget? content;

  final Widget? overlay;

  final VoidCallback? onTap;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      borderRadius: borderRadius,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: imageHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (image != null)
                  Image(image: image!, fit: BoxFit.cover)
                else
                  ColoredBox(
                    color: colors.surfaceContainerHigh,
                    child: Icon(
                      Icons.image_outlined,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                if (overlay != null)
                  Positioned(
                    top: AppSpacing.sm,
                    right: AppSpacing.sm,
                    child: overlay!,
                  ),
              ],
            ),
          ),
          if (content != null)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: content,
            ),
        ],
      ),
    );
  }
}
