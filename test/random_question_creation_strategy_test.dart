import 'package:flutter_test/flutter_test.dart';
import 'package:guitar_notes/note.dart';
import 'package:guitar_notes/question_creation_strategy.dart';

void main() {
  group("RandomQuestionCreationStrategy", () {
    group('createNextQuestion', () {
      test('should calculate a new question for every call', () {
        final strategy = RandomQuestionCreationStrategy(strings: [
          Note.E,
          Note.A,
          Note.D,
          Note.G,
          Note.B,
          Note.E,
        ]);

        final question = strategy.createNextQuestion();
        expect(question, isNotNull);

        final question2 = strategy.createNextQuestion();
        expect(question2, isNotNull);

        expect(question, isNot(equals(question2)));
      });

      test('should work for every string set', () {
        final tunings = [
          [
            Note.E,
            Note.A,
            Note.D,
            Note.G,
            Note.B,
            Note.E,
          ],
          [
            Note.cSharp,
            Note.gSharp,
            Note.fSharp,
          ]
        ];

        for (final tuning in tunings) {
          for (int i = 0; i < 100; i++) {
            final strategy = RandomQuestionCreationStrategy(strings: tuning);

            final question = strategy.createNextQuestion();
            expect(
              tuning.contains(question.string),
              true,
            );
          }
        }
      });
    });
  });
}
