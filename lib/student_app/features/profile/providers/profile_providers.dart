import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/providers/auth_providers.dart' show dioProvider;
import '../repository/models/user_profile.dart';
import '../repository/profile_repository.dart';
import '../utils/avatar_image.dart';

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepository(ref.watch(dioProvider)),
);

final userProfileProvider = FutureProvider.autoDispose<UserProfile>(
  (ref) => ref.watch(profileRepositoryProvider).getProfile(),
);

final profileEditControllerProvider =
    NotifierProvider.autoDispose<ProfileEditController, bool>(
  ProfileEditController.new,
);

class ProfileEditController extends Notifier<bool> {
  @override
  bool build() => false;

  ProfileRepository get _repo => ref.read(profileRepositoryProvider);

  Future<String?> save(UpdateUserPayload payload) async {
    state = true;
    try {
      await _repo.updateUser(payload);
      ref.invalidate(userProfileProvider);
      return null;
    } on ProfileException catch (e) {
      return e.message;
    } catch (_) {
      return 'Could not update your profile.';
    } finally {
      state = false;
    }
  }
}

final avatarCacheBustProvider =
    NotifierProvider<AvatarCacheBust, int>(AvatarCacheBust.new);

class AvatarCacheBust extends Notifier<int> {
  @override
  int build() => 0;

  void bump() => state = DateTime.now().millisecondsSinceEpoch;
}

final avatarUploadControllerProvider =
    NotifierProvider.autoDispose<AvatarUploadController, bool>(
  AvatarUploadController.new,
);

class AvatarUploadController extends Notifier<bool> {
  @override
  bool build() => false;

  ProfileRepository get _repo => ref.read(profileRepositoryProvider);

  Future<String?> upload(ProcessedAvatar avatar) async {
    state = true;
    try {
      await _repo.uploadAvatar(
        avatar.bytes,
        filename: avatar.filename,
        subtype: avatar.subtype,
      );
      ref.read(avatarCacheBustProvider.notifier).bump();
      ref.invalidate(userProfileProvider);
      return null;
    } on ProfileException catch (e) {
      return e.message;
    } catch (_) {
      return 'Could not update your profile picture.';
    } finally {
      state = false;
    }
  }
}
