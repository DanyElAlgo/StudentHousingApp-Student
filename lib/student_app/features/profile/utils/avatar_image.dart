import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../repository/profile_repository.dart';

class ProcessedAvatar {
  const ProcessedAvatar({
    required this.bytes,
    required this.subtype,
    required this.filename,
  });

  final Uint8List bytes;
  final String subtype;
  final String filename;
}

const int _targetSize = 512;
const int _quality = 80;

Future<ProcessedAvatar> processAvatar(XFile file) async {
  final bytes = await file.readAsBytes();
  if (_isGif(file)) {
    throw const ProfileException(
      'That image type is not supported. Pick a JPG, PNG or WebP image.',
    );
  }

  final webp = await _tryCompress(bytes, CompressFormat.webp);
  if (webp != null) {
    return ProcessedAvatar(
      bytes: webp,
      subtype: 'webp',
      filename: 'avatar.webp',
    );
  }

  final jpeg = await _tryCompress(bytes, CompressFormat.jpeg);
  if (jpeg != null) {
    return ProcessedAvatar(
      bytes: jpeg,
      subtype: 'jpeg',
      filename: 'avatar.jpg',
    );
  }

  throw const ProfileException('Could not process the selected image.');
}

Future<Uint8List?> _tryCompress(
  Uint8List source,
  CompressFormat format,
) async {
  try {
    final result = await FlutterImageCompress.compressWithList(
      source,
      minWidth: _targetSize,
      minHeight: _targetSize,
      quality: _quality,
      format: format,
    );
    return result.isEmpty ? null : result;
  } on UnsupportedError {
    return null;
  } catch (_) {
    return null;
  }
}

bool _isGif(XFile file) {
  final mime = file.mimeType?.toLowerCase();
  if (mime != null && mime.contains('gif')) return true;
  return file.name.toLowerCase().endsWith('.gif');
}
