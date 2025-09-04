import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

final pinServiceProvider = Provider<PinService>((_) => PinService());

class PinService {
  static const _storage = FlutterSecureStorage();
  static const _pinKey = 'app_pin_v1';
  final _auth = LocalAuthentication();

  Future<void> init() async {
    // no-op, but kept for symmetry and future migrations
  }

  Future<bool> hasPin() async => (await _storage.read(key: _pinKey)) != null;

  Future<void> setPin(String pin) async {
    if (!(pin.length == 4 || pin.length == 6)) throw Exception('PIN must be 4 or 6 digits');
    await _storage.write(key: _pinKey, value: pin);
  }

  Future<bool> verifyPin(String pin) async {
    final saved = await _storage.read(key: _pinKey);
    return saved == pin;
  }

  Future<bool> biometricAvailable() async {
    try {
      return await _auth.canCheckBiometrics && await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  Future<bool> biometricAuth() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Unlock to access your expenses',
        options: const AuthenticationOptions(biometricOnly: true, stickyAuth: true),
      );
    } catch (_) {
      return false;
    }
  }
}
