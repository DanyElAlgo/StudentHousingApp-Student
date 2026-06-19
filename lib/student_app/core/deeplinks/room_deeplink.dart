const String roomLinkScheme = 'studentlib';
const String roomLinkHost = 'room';

String buildRoomDeepLink(int roomId) => '$roomLinkScheme://$roomLinkHost/$roomId';

int? parseRoomDeepLink(Uri uri) {
  if (uri.scheme != roomLinkScheme || uri.host != roomLinkHost) return null;
  if (uri.pathSegments.isEmpty) return null;
  return int.tryParse(uri.pathSegments.first);
}
