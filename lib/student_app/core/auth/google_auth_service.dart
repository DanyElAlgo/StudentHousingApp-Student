import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../config/app_config.dart';

class GoogleAuthService {
  GoogleAuthService._();

  static final GoogleAuthService instance = GoogleAuthService._();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    await GoogleSignIn.instance.initialize(
      clientId: kIsWeb ? AppConfig.googleWebClientId : null,
      serverClientId: kIsWeb ? null : AppConfig.googleWebClientId,
    );
    _initialized = true;
  }

  Stream<String> get idTokens {
    return GoogleSignIn.instance.authenticationEvents
        .where((e) => e is GoogleSignInAuthenticationEventSignIn)
        .cast<GoogleSignInAuthenticationEventSignIn>()
        .map((e) => e.user.authentication.idToken)
        .where((token) => token != null)
        .cast<String>();
  }

  Future<String?> signInAndGetIdToken() async {
    if (!GoogleSignIn.instance.supportsAuthenticate()) return null;
    try {
      final account = await GoogleSignIn.instance.authenticate();
      return account.authentication.idToken;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return null;
      rethrow;
    }
  }

  Future<void> signOut() => GoogleSignIn.instance.signOut();
}
