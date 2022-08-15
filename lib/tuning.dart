import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'note.dart';

@immutable
class Tuning {
  final List<Note> _strings;

  UnmodifiableListView<Note> get strings => UnmodifiableListView(_strings);

  const Tuning({required List<Note> strings}) : _strings = strings;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Tuning && runtimeType == other.runtimeType && _strings.equals(other._strings);

  @override
  int get hashCode => strings.hashCode;

  List<Note> get distinctNotes => _strings.toSet().toList();

  @override
  String toString() => 'Tuning($strings)';
}

class Tunings {
  static Tuning get standard => _standardTuning;
  static Tuning get halfStepDown => standard.steppedDown(steps: 1);
  static Tuning get wholeStepDown => standard.steppedDown(steps: 2);
}

extension TuningManipulation on Tuning {
  Tuning steppedDown({required int steps}) {
    final List<Note> result = [];
    for (int i = 0; i < _strings.length; i++) {
      final originalNote = _strings[i];
      final newNote = originalNote.decrement(by: steps);
      result.add(newNote);
    }
    return Tuning(strings: result);
  }

  Tuning get dropped {
    final List<Note> result = List.from(_strings);
    result[0] = result[0].decrement(by: 2);
    return Tuning(strings: result);
  }
}

const Tuning _standardTuning = Tuning(strings: [
  Note.E,
  Note.A,
  Note.D,
  Note.G,
  Note.B,
  Note.E,
]);
