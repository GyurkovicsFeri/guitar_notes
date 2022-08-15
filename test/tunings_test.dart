import 'package:flutter_test/flutter_test.dart';
import 'package:guitar_notes/note.dart';
import 'package:guitar_notes/tuning.dart';

void main() {
  group("Tunings", () {
    test('standard', () {
      expect(
        Tunings.standard,
        equals(
          const Tuning(
            strings: [
              Note.E,
              Note.A,
              Note.D,
              Note.G,
              Note.B,
              Note.E,
            ],
          ),
        ),
      );
    });

    test('halfStepDown', () {
      expect(
        Tunings.halfStepDown,
        equals(const Tuning(strings: [
          Note.dSharp,
          Note.gSharp,
          Note.cSharp,
          Note.fSharp,
          Note.aSharp,
          Note.dSharp,
        ])),
      );
    });

    test('wholeStepDown', () {
      expect(
        Tunings.wholeStepDown,
        equals(const Tuning(strings: [
          Note.D,
          Note.G,
          Note.C,
          Note.F,
          Note.A,
          Note.D,
        ])),
      );
    });
  });
}
