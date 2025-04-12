import 'package:local_auth/local_auth.dart';

class BiometricHelper {
  static final LocalAuthentication localAuth = LocalAuthentication();

  static Future<bool> authenticate() async {
    bool isAuthenticated = false;

    try {
      bool canCheckBiometrics = await localAuth.canCheckBiometrics;
      bool isDeviceSupported = await localAuth.isDeviceSupported();

      if (!canCheckBiometrics || !isDeviceSupported) {
        print("Device not supported or biometrics not available");
        print('-------canCheckbiometric $canCheckBiometrics ---------$isDeviceSupported');
        return false;
      }

      List<BiometricType> availableBiometrics = await localAuth.getAvailableBiometrics();
      if (availableBiometrics.isEmpty) {
        print("No biometrics enrolled on this device.");
        return false;
      }

      isAuthenticated = await localAuth.authenticate(
        localizedReason: 'Please authenticate to access this feature',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print("Biometric error: $e");
    }

    return isAuthenticated;
  }
}
