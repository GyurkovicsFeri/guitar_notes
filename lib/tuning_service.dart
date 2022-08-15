import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'note.dart';

class TuningService extends ChangeNotifier {
  List<Note> _strings;

  TuningService({required List<Note> strings}) : _strings = strings;

  List<Note> get strings => UnmodifiableListView(_strings);
  set strings(List<Note> value) {
    _strings = value;
    notifyListeners();
  }

  static List<Note> getStandardTuning() {
    return [
      Note.E,
      Note.A,
      Note.D,
      Note.G,
      Note.B,
      Note.E,
    ];
  }

  static List<Note> stepDown(List<Note> tuning, int steps) {
    final List<Note> result = [];
    for (int i = 0; i < tuning.length; i++) {
      final originalNote = tuning[i];
      final newNote = originalNote.stepDown(steps);
      result.add(newNote);
    }
    return result;
  }

  static List<Note> drop(List<Note> tuning) {
    final List<Note> result = List.from(tuning);
    result[0] = result[0].stepDown(2);
    return result;
  }
}
