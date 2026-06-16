import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/providers/auth_providers.dart' show dioProvider;
import '../repository/models/user_profile.dart';
import '../repository/profile_repository.dart';

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
