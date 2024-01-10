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
    final storedString = _prefs.getString('image_cards_list');
    if (storedString != null) {
      final individualJsons = storedString.split('|');
      final deserializedList =
          individualJsons.map((json) => jsonDecode(json)).toList();
      List<ImageCard> imageCardList = [];
      for (final item in deserializedList) {
        ImageCard ic = ImageCard.fromJson(item);
        imageCardList.add(ic);
      }
      return imageCardList;
    }
    return [];
  }

  void _saveSharedPreferences() {
    if (state.isNotEmpty) {
      final jsonList = state.map((card) => jsonEncode(card.toJson()));
      final joinedString = jsonList.join('|');
      _prefs.setString('image_cards_list', joinedString);
    } else {
      _prefs.remove('image_cards_list');
    }
  }

  @override
  List<ImageCard> build() {
    return _fetchCards();
  }

  void addImageCard(ImageCard imageCard) {
    state = [...state, imageCard];
    _saveSharedPreferences();
  }

  void removeImageCard(String imageCardId) {
    state = [
      for (final card in state)
        if (card.id != imageCardId) card,
    ];
    _saveSharedPreferences();
  }

  void editImageCard(ImageCard imageCard) {
    state = [
      for (final card in state)
        if (card.id == imageCard.id) imageCard else card
    ];
    _saveSharedPreferences();
  }
}
