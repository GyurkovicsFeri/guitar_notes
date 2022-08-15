// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:guitar_notes/note.dart';
import 'package:guitar_notes/tuning.dart';

void main() {
  group("Tuning", () {
    test('should be created by the notes in proper order', () {
      expect(
        const Tuning(
          strings: [
            Note.E,
            Note.A,
            Note.D,
            Note.G,
            Note.B,
            Note.E,
          ],
        ).strings,
        equals(
          [
            Note.E,
            Note.A,
            Note.D,
            Note.G,
            Note.B,
            Note.E,
          ],
        ),
      );

      expect(
          const Tuning(strings: [
            Note.E,
          ]).strings,
          equals([
            Note.E,
          ]));
    });

    test('should be equal to other tuning only if every string is the same in the same order', () {
      expect(
          Tuning(strings: [
            Note.E,
            Note.A,
            Note.D,
            Note.G,
            Note.B,
            Note.E,
          ]),
          equals(Tuning(strings: [
            Note.E,
            Note.A,
            Note.D,
            Note.G,
            Note.B,
            Note.E,
          ])));

      expect(
          const Tuning(strings: [
            Note.E,
            Note.A,
          ]),
          isNot(equals(const Tuning(strings: [
            Note.A,
            Note.E,
          ]))));
    });
  });

  group("steppedDown", () {
    test("should step down the tuning", () {
      final steppedDown = Tunings.standard.steppedDown(steps: 2);
      expect(
        steppedDown,
        equals(
          const Tuning(
            strings: [
              Note.D,
              Note.G,
              Note.C,
              Note.F,
              Note.A,
              Note.D,
            ],
          ),
        ),
      );
    });
  });

  group("dropped", () {
    test("should step down the tuning", () {
      final dropped = Tunings.standard.dropped;
      expect(
        dropped,
        equals(
          const Tuning(
            strings: [
              Note.D,
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
  });
}
