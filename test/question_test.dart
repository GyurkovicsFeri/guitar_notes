import 'package:flutter_test/flutter_test.dart';
import 'package:guitar_notes/note.dart';
import 'package:guitar_notes/question.dart';

void main() {
  group("Question", () {
    group('forStringAndFret', () {
      test('should have the correct properties', () {
        final question = Question(
          string: Note.E,
          fret: 3,
        );

        expect(question.hint, 'E3');
        expect(question.fret, 3);
        expect(question.string, Note.E);
      });
    });

    group('equality', () {
      test('should be equal if the string and fret are equal', () {
        final question1 = Question(
          string: Note.E,
          fret: 3,
        );
        final question2 = Question(
          string: Note.E,
          fret: 3,
        );
        expect(question1, question2);
      });
    });
  });
}
