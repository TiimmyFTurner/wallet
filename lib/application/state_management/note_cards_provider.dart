import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wallet/application/state_management/shared_preferences_provider.dart';
import 'package:wallet/domain/note_card_model.dart';

part 'note_cards_provider.g.dart';

@riverpod
class NoteCards extends _$NoteCards {
  dynamic _prefs;

  List<NoteCard> _fetchCards() {
    _prefs = ref.watch(sharedPreferencesProvider);
    final storedString = _prefs.getString('note_cards_list');
    if (storedString != null) {
      final individualJsons = storedString.split('|');
      final deserializedList =
          individualJsons.map((json) => jsonDecode(json)).toList();
      List<NoteCard> noteCardList = [];
      for (final item in deserializedList) {
        NoteCard nc = NoteCard.fromJson(item);
        noteCardList.add(nc);
      }
      return noteCardList;
    }
    return [];
  }

  void _saveSharedPreferences() {
    if (state != []) {
      final jsonList = state.map((card) => jsonEncode(card.toJson()));
      final joinedString = jsonList.join('|');
      _prefs.setString('note_cards_list', joinedString);
    } else {
      _prefs.remove('note_cards_list');
    }
  }

  @override
  List<NoteCard> build() {
    return _fetchCards();
  }

  void addNoteCard(NoteCard noteCard) {
    state = [...state, noteCard];
    _saveSharedPreferences();
  }

  void removeNoteCard(String noteCardId) {
    state = [
      for (final card in state)
        if (card.id != noteCardId) card,
    ];
    _saveSharedPreferences();
  }

  void editNoteCard(NoteCard noteCard) {
    state = [
      for (final card in state)
        if (card.id == noteCard.id) noteCard else card
    ];
    _saveSharedPreferences();
  }
}
