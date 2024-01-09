import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wallet/application/state_management/shared_preferences_provider.dart';
import 'package:wallet/domain/image_card_model.dart';

part 'image_cards_provider.g.dart';

@riverpod
class ImageCards extends _$ImageCards {
  dynamic _prefs;

  List<ImageCard> _fetchCards() {
    _prefs = ref.watch(sharedPreferencesProvider);
    final storedString = _prefs.getString('note_cards_list');
    if (storedString != null) {
      final individualJsons = storedString.split('|');
      final deserializedList =
          individualJsons.map((json) => jsonDecode(json)).toList();
      List<ImageCard> noteCardList = [];
      for (final item in deserializedList) {
        ImageCard nc = ImageCard.fromJson(item);
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
    }
  }

  @override
  List<ImageCard> build() {
    return _fetchCards();
  }

  void addImageCard(ImageCard noteCard) {
    state = [...state, noteCard];
    _saveSharedPreferences();
  }

  void removeImageCard(String noteCardId) {
    state = [
      for (final card in state)
        if (card.id != noteCardId) card,
    ];
    _saveSharedPreferences();
  }

  void editImageCard(ImageCard noteCard) {
    state = [
      for (final card in state)
        if (card.id == noteCard.id) noteCard else card
    ];
    _saveSharedPreferences();
  }
}
