import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../../../core/utils/formatters.dart';
import '../providers/profile_providers.dart';
import '../repository/models/user_profile.dart';
import '../repository/profile_repository.dart';
import '../utils/avatar_image.dart';

class EditableAvatar extends ConsumerStatefulWidget {
  const EditableAvatar({super.key, required this.profile});

  final UserProfile profile;

  @override
  ConsumerState<EditableAvatar> createState() => _EditableAvatarState();
}

class _EditableAvatarState extends ConsumerState<EditableAvatar> {
  static const double _radius = 44;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool uploading = ref.watch(avatarUploadControllerProvider);
    final int bust = ref.watch(avatarCacheBustProvider);

    final String raw = widget.profile.imageUrl.trim();
    final bool hasImage = raw.isNotEmpty;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: _radius * 2,
          height: _radius * 2,
          child: ClipOval(
            child: DecoratedBox(
              decoration: BoxDecoration(color: colors.primary),
              child: hasImage
                  ? Image.network(
                      _bustedUrl(raw, bust),
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _placeholder(colors),
                    )
                  : _placeholder(colors),
            ),
          ),
        ),
        if (uploading)
          Positioned.fill(
            child: ClipOval(
              child: ColoredBox(
                color: Colors.black45,
                child: Center(
                  child: SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: colors.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          right: -2,
          bottom: -2,
          child: Tooltip(
            message: l10n.profileChangePhoto,
            child: Material(
              color: colors.primary,
              elevation: 2,
              shape: CircleBorder(
                side: BorderSide(color: colors.surface, width: 2),
              ),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: uploading ? null : _onEditPressed,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Icon(Icons.edit, size: 18, color: colors.onPrimary),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _placeholder(ColorScheme colors) => Center(
        child: Icon(Icons.person, size: _radius, color: colors.onPrimary),
      );

  String _bustedUrl(String raw, int bust) => resolveImageUrl(raw);

  Future<void> _onEditPressed() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!kIsWeb)
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: Text(l10n.profileTakePhoto),
                onTap: () => Navigator.pop(ctx, ImageSource.camera),
              ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(l10n.profileChooseGallery),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;
    await _pickAndUpload(source);
  }

  Future<void> _pickAndUpload(ImageSource source) async {
    final AppLocalizations l10n = AppLocalizations.of(context);

    final XFile? file;
    try {
      file = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 90,
      );
    } catch (_) {
      _showMessage(l10n.profilePhotoError);
      return;
    }
    if (file == null || !mounted) return;

    final Uint8List preview = await file.readAsBytes();
    if (!mounted) return;

    final bool confirmed = await _showPreview(preview) ?? false;
    if (!confirmed || !mounted) return;

    final ProcessedAvatar processed;
    try {
      processed = await processAvatar(file);
    } on ProfileException catch (e) {
      _showMessage(e.message);
      return;
    } catch (_) {
      _showMessage(l10n.profilePhotoError);
      return;
    }

    final String? error =
        await ref.read(avatarUploadControllerProvider.notifier).upload(processed);
    if (!mounted) return;
    _showMessage(error ?? l10n.profilePhotoUpdated);
  }

  Future<bool?> _showPreview(Uint8List bytes) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.profilePhotoPreviewTitle),
        content: ClipOval(
          child: Image.memory(
            bytes,
            width: 180,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.profilePhotoConfirm),
          ),
        ],
      ),
    );
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
