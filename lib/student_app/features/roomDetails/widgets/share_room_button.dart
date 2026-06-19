import 'package:flutter/material.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:share_plus/share_plus.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../../../core/deeplinks/room_deeplink.dart';
import '../../rooms/repository/models/room.dart';

class ShareRoomButton extends StatelessWidget {
  const ShareRoomButton({super.key, required this.room});

  final Room room;

  Future<void> _share(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final url = buildRoomDeepLink(room.id);

    final box = context.findRenderObject() as RenderBox?;
    final origin = box != null && box.hasSize
        ? box.localToGlobal(Offset.zero) & box.size
        : null;

    await SharePlus.instance.share(
      ShareParams(
        text: l10n.detailsShareMessage(room.name, url),
        subject: room.name,
        sharePositionOrigin: origin,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppSecondaryButton(
      label: AppLocalizations.of(context).detailsShareButton,
      icon: Icons.share_outlined,
      onPressed: () => _share(context),
    );
  }
}
