import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wallet/application/state_management/credit_cards_provider.dart';
import 'package:wallet/application/state_management/id_cards_provider.dart';
import 'package:wallet/application/state_management/note_cards_provider.dart';
import 'package:wallet/domain/credit_card_model.dart';
import 'package:wallet/domain/id_card_model.dart';
import 'package:wallet/domain/note_card_model.dart';

part 'backup_provider.g.dart';

final Codec<String, String> sTB64 = utf8.fuse(base64);

@riverpod
class BackupString extends _$BackupString {
  String _creditCardBackup() {
    List<CreditCard> creditCards = ref.read(creditCardsProvider);
    if (creditCards.isEmpty) return '';
    final jsonList = creditCards.map((card) => jsonEncode(card.toJson()));
    return "cc|~|${jsonList.join('|~|')}|~~|";
  }

  String _idCardsBackup() {
    List<IDCard> idCards = ref.read(iDCardsProvider);
    if (idCards.isEmpty) return '';
    final jsonList = idCards.map((card) => jsonEncode(card.toJson()));
    return "ic|~|${jsonList.join('|~|')}|~~|";
  }

  String _noteCardsBackup() {
    List<NoteCard> noteCards = ref.read(noteCardsProvider);
    if (noteCards.isEmpty) return '';
    final jsonList = noteCards.map((card) => jsonEncode(card.toJson()));
    return "nc|~|${jsonList.join('|~|')}";
  }

  @override
  String build() {
    String backupString =
        _creditCardBackup() + _idCardsBackup() + _noteCardsBackup();
    return sTB64.encode(backupString);
  }

  void restoreBackup(String backupString) {
    String decodedBackupString = sTB64.decode(backupString);
    List backupParts = decodedBackupString.split('|~~|');
    for (String part in backupParts) {
      List backupSections = part.split('|~|');
      //
      if (backupSections[0] == 'cc') {
        final creditCardsList = ref.read(creditCardsProvider);
        backupSections.removeAt(0);
        final ccList = backupSections.map((json) => jsonDecode(json)).toList();
        for (final card in ccList) {
          CreditCard cc = CreditCard.fromJson(card);
          if (!creditCardsList.any((element) => element.id == cc.id)) {
            ref.read(creditCardsProvider.notifier).addCreditCard(cc);
          }
        }
      } else if (backupSections[0] == 'ic') {
        final idCardsList = ref.read(iDCardsProvider);
        backupSections.removeAt(0);
        final icList = backupSections.map((json) => jsonDecode(json)).toList();
        for (final card in icList) {
          IDCard ic = IDCard.fromJson(card);
          if (!idCardsList.any((element) => element.id == ic.id)) {
            ref.read(iDCardsProvider.notifier).addIDCard(ic);
          }
        }
      } else if (backupSections[0] == 'nc') {
        final noteCardsList = ref.read(noteCardsProvider);
        backupSections.removeAt(0);
        final ncList = backupSections.map((json) => jsonDecode(json)).toList();
        for (final card in ncList) {
          NoteCard nc = NoteCard.fromJson(card);
          if (!noteCardsList.any((element) => element.id == nc.id)) {
            ref.read(noteCardsProvider.notifier).addNoteCard(nc);
          }
        }
      }
    }
  }
}
