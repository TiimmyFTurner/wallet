import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wallet/application/state_management/shared_preferences_provider.dart';

part 'password_provider.g.dart';

@Riverpod(keepAlive: true)
class Password extends _$Password {
  dynamic _prefs;

  String _fetchPassword() {
    _prefs = ref.watch(sharedPreferencesProvider);
    final storedPassword = _prefs.getString('password');
    return storedPassword ?? "";
  }

  @override
  String build() {
    return _fetchPassword();
  }

  void setPassword(String password) {
    state = password;
    _prefs.setString('password', state);
  }
}

@riverpod
class PasswordStatus extends _$PasswordStatus {
  dynamic _prefs;

  @override
  bool build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    final storedPassword = _prefs.getBool('passwordStatus');
    return storedPassword ?? true;
  }
  void toggle(){
    state = !state;
    _prefs.setBool('passwordStatus', state);
  }
}
