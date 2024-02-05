import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wallet/application/state_management/shared_preferences_provider.dart';

part 'first_time_provider.g.dart';



@riverpod
class FirstTime extends _$FirstTime {
  dynamic _prefs;

  @override
  bool build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    final storedPassword = _prefs.getBool('firstTime');
    return storedPassword ?? true;
  }
  void toggle(){
    state = !state;
    _prefs.setBool('firstTime', state);
  }
}
