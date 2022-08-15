import 'package:flutter_test/flutter_test.dart';
import 'package:guitar_notes/note.dart';
import 'package:guitar_notes/tuning_service.dart';

void main() {
  group("TuningService", () {
    test('should notify listeners on tuning changes', () {
      var isCalled = false;
      final service = TuningService(strings: [
        Note.E,
        Note.A,
        Note.D,
        Note.G,
        Note.B,
      ]);
      service.addListener(() {
        isCalled = true;
      });
      service.strings = [Note.F, Note.A, Note.D, Note.G, Note.B, Note.E];
      expect(isCalled, equals(true));
    });

    group("stepDown", () {
      test("should step down the tuning", () {
        final original = [
          Note.E,
          Note.A,
          Note.D,
          Note.G,
          Note.B,
          Note.E,
        ];
        final steppedDown = TuningService.stepDown(original, 2);
        expect(
            steppedDown,
            equals([
              Note.D,
              Note.G,
              Note.C,
              Note.F,
              Note.A,
              Note.D,
            ]));
      });
    });

    group("drop", () {
      test("should step down the tuning", () {
        final original = [
          Note.E,
          Note.A,
          Note.D,
          Note.G,
          Note.B,
          Note.E,
        ];
        final steppedDown = TuningService.drop(original);
        expect(
            steppedDown,
            equals([
              Note.D,
              Note.A,
              Note.D,
              Note.G,
              Note.B,
              Note.E,
            ]));
      });
    });
  });
}
