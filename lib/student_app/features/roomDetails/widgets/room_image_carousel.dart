import 'package:flutter/material.dart';
import 'package:housing_design_system/housing_design_system.dart';

import '../../../core/utils/formatters.dart';

class RoomImageCarousel extends StatefulWidget {
  const RoomImageCarousel({super.key, required this.imageUrls, this.height = 260});

  final List<String> imageUrls;
  final double height;

  @override
  State<RoomImageCarousel> createState() => _RoomImageCarouselState();
}

class _RoomImageCarouselState extends State<RoomImageCarousel> {
  final PageController _controller = PageController();
  int _current = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    if (widget.imageUrls.isEmpty) {
      return Container(
        height: widget.height,
        color: colors.surfaceContainerHigh,
        alignment: Alignment.center,
        child: Icon(
          Icons.image_outlined,
          size: 48,
          color: colors.onSurfaceVariant,
        ),
      );
    }

    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.imageUrls.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (context, index) => Image(
              image: NetworkImage(resolveImageUrl(widget.imageUrls[index])),
              fit: BoxFit.cover,
              errorBuilder: (context, _, _) => ColoredBox(
                color: colors.surfaceContainerHigh,
                child: Icon(
                  Icons.broken_image_outlined,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
          ),
          if (widget.imageUrls.length > 1)
            Positioned(
              bottom: AppSpacing.md,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < widget.imageUrls.length; i++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: i == _current ? 18 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: i == _current
                            ? colors.onPrimary
                            : colors.onPrimary.withValues(alpha: 0.5),
                        borderRadius: AppRadii.pill,
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
