import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wallet/application/state_management/shared_preferences_provider.dart';
import 'package:wallet/domain/id_card_model.dart';

part 'id_cards_provider.g.dart';

@riverpod
class IDCards extends _$IDCards {
  dynamic _prefs;

  List<IDCard> _fetchCards() {
    _prefs = ref.watch(sharedPreferencesProvider);
    final storedString = _prefs.getString('id_cards_list');
    if (storedString != null) {
      final individualJsons = storedString.split('|');
      final deserializedList =
          individualJsons.map((json) => jsonDecode(json)).toList();
      List<IDCard> idCardList = [];
      for (final item in deserializedList) {
        IDCard cc = IDCard.fromJson(item);
        idCardList.add(cc);
      }
      return idCardList;
    }
    return [];
  }

  void _saveSharedPreferences() {
    if (state.isNotEmpty) {
      final jsonList = state.map((card) => jsonEncode(card.toJson()));
      final joinedString = jsonList.join('|');
      _prefs.setString('id_cards_list', joinedString);
    } else {
      _prefs.remove('id_cards_list');
    }
  }

  @override
  List<IDCard> build() {
    return _fetchCards();
  }

  void addIDCard(IDCard idCard) {
    state = [...state, idCard];
    _saveSharedPreferences();
  }

  void removeIDCard(String idCardId) {
    state = [
      for (final card in state)
        if (card.id != idCardId) card,
    ];
    _saveSharedPreferences();
  }

  void editIDCard(IDCard idCard) {
    state = [
      for (final card in state)
        if (card.id == idCard.id) idCard else card
    ];
    _saveSharedPreferences();
  }
}
