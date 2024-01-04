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
      final individualJsons = storedString.split(',');
      final deserializedList =
          individualJsons.map((json) => jsonDecode(json)).toList();
      final creditCardsList =
          deserializedList.map((card) => CreditCard.fromJson(card));
      return creditCardsList;
    }
    return [];
  }

  @override
  List<CreditCard> build() {
    return _fetchCards();
  }

  void addCreditCard(CreditCard creditCard) {
    state = [...state, creditCard];

    final jsonList = state.map((card) => card.toJson());
    final joinedString = jsonList.join(',');
    _prefs.setString('credit_cards_list', joinedString);
  }

  void removeCreditCard(CreditCard creditCard) {
    state = [
      for (final card in state)
        if (card != creditCard) card,
    ];
    if (state != []) {
      final jsonList = state.map((card) => card.toJson());
      final joinedString = jsonList.join(',');
      _prefs.setString('credit_cards_list', joinedString);
    }
  }

// Let's mark a todo as completed
// void toggle(String todoId) {
//   state = [
//     for (final todo in state)
//     // we're marking only the matching todo as completed
//       if (todo.id == todoId)
//       // Once more, since our state is immutable, we need to make a copy
//       // of the todo. We're using our `copyWith` method implemented before
//       // to help with that.
//         todo.copyWith(completed: !todo.completed)
//       else
//       // other todos are not modified
//         todo,
//   ];
// }
}
