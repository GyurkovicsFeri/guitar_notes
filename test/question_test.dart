// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:guitar_notes/guitar_notes_service.dart';

void main() {
  group("Question", () {
    group('forStringAndFret', () {
      test('should return the correct answer', () {
        final question = Question.forStringAndFret(
          string: Note.E,
          fret: 3,
        );

        expect(question, isNotNull);
        expect(question.hint, 'E3');
        expect(question.answer, Note.G);
      });

      test('should return the correct answer for big frets', () {
        final question = Question.forStringAndFret(
          string: Note.G,
          fret: 13,
        );

        expect(question, isNotNull);
        expect(question.hint, 'G13');
        expect(question.answer, Note.gSharp);
      });
    });
  });
}
