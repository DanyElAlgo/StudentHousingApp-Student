import '../config/app_config.dart';

String buildRoomDeepLink(int roomId) => '${AppConfig.webBaseUrl}/room/$roomId';
