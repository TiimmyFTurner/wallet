import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wallet/application/state_management/shared_preferences_provider.dart';
import 'package:wallet/domain/credit_card_model.dart';

part 'credit_cards_provider.g.dart';

@riverpod
class CreditCards extends _$CreditCards {
  dynamic _prefs;

  List<CreditCard> _fetchCards() {
    _prefs = ref.watch(sharedPreferencesProvider);
    final storedString = _prefs.getString('credit_cards_list');
    if (storedString != null) {
      final individualJsons = storedString.split('|');
      final deserializedList =
          individualJsons.map((json) => jsonDecode(json)).toList();
      List<CreditCard> creditCardList = [];
      for (final item in deserializedList) {
        CreditCard cc = CreditCard.fromJson(item);
        creditCardList.add(cc);
      }
      return creditCardList;
    }
    return [];
  }

  void _saveSharedPreferences() {
    if (state != []) {
      final jsonList = state.map((card) => jsonEncode(card.toJson()));
      final joinedString = jsonList.join('|');
      _prefs.setString('credit_cards_list', joinedString);
    }
  }

  @override
  List<CreditCard> build() {
    return _fetchCards();
  }

  void addCreditCard(CreditCard creditCard) {
    state = [...state, creditCard];
    _saveSharedPreferences();
  }

  void removeCreditCard(String creditCardId) {
    state = [
      for (final card in state)
        if (card.id != creditCardId) card,
    ];
    _saveSharedPreferences();
  }

  void editCreditCard(CreditCard creditCard) {
    state = [
      for (final card in state)
        if (card.id == creditCard.id) creditCard else card
    ];
    _saveSharedPreferences();
  }
}
