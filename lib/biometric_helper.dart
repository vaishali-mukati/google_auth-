import 'package:local_auth/local_auth.dart';

class BiometricHelper {
  static Future<bool> authenticate() async {
    try {
      final localAuth = LocalAuthentication();
      bool canCheck = await localAuth.canCheckBiometrics;
      if (!canCheck) return false;

      return await localAuth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      print('Biometric auth error: $e');
      return false; // Default to false on error
    }
  }
}
