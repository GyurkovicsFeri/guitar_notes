import 'package:flutter_test/flutter_test.dart';
import 'package:guitar_notes/note.dart';
import 'package:guitar_notes/question.dart';
import 'package:guitar_notes/question_solver.dart';

void main() {
  group("QuestionSolver", () {
    group('answer', () {
      test('should calculate the correct note', () {
        final solver = QuestionSolver();
        final question = Question(
          string: Note.E,
          fret: 3,
        );
        expect(solver.answer(of: question), Note.G);

        final question2 = Question(
          string: Note.E,
          fret: 4,
        );
        expect(solver.answer(of: question2), Note.gSharp);

        final question3 = Question(
          string: Note.E,
          fret: 5,
        );
        expect(solver.answer(of: question3), Note.A);

        final question4 = Question(
          string: Note.A,
          fret: 5,
        );
        expect(solver.answer(of: question4), Note.D);
      });
    });
  });
}
