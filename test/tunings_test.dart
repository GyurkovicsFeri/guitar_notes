import 'package:flutter_test/flutter_test.dart';
import 'package:guitar_notes/guitar_notes_service.dart';
import 'package:guitar_notes/note.dart';
import 'package:guitar_notes/tuning_service.dart';

void main() {
  group("Tunings", () {
    test('create Drop D', () {
      expect(
          TuningService.getStandardTuning().drop(),
          equals([
            Note.D,
            Note.A,
            Note.D,
            Note.G,
            Note.B,
            Note.E,
          ]));
    });

    test('create Drop C', () {
      expect(
          TuningService.getStandardTuning().stepDown(2).drop(),
          equals([
            Note.C,
            Note.G,
            Note.C,
            Note.F,
            Note.A,
            Note.D,
          ]));
    });
  });
}
