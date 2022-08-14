import 'package:flutter_test/flutter_test.dart';
import 'package:guitar_notes/guitar_notes_service.dart';

void main() {
  group("Guitar Notes Service", () {
    group('nextQuestion', () {
      test('should generate a new question based on the strategy', () {
        final service = GuitarNotesService(
          creation: ConstantQuestionCreationStrategy(question: Question(string: Note.E, fret: 0)),
          solver: ConstantNoteQuestionSolver(answer: Note.E),
        );

        final question = service.nextQuestion();
        expect(question, isNotNull);
        expect(question, Question(string: Note.E, fret: 0));
        expect(service.currentQuestion, equals(question));
      });

      test('should notify listeners', () {
        var isCalled = false;
        final service = GuitarNotesService(
          creation: ConstantQuestionCreationStrategy(question: Question(string: Note.E, fret: 0)),
          solver: ConstantNoteQuestionSolver(answer: Note.E),
        );
        Question? questionFromListener;
        service.addListener(() {
          questionFromListener = service.currentQuestion;
          isCalled = true;
        });
        final questionFromReturn = service.nextQuestion();
        expect(isCalled, equals(true));
        expect(questionFromListener, equals(questionFromReturn));
      });

      test('should create a new question every time', () async {
        final creationStrategy = ConstantQuestionCreationStrategy(question: Question(string: Note.E, fret: 0));

        final service = GuitarNotesService(
          creation: creationStrategy,
          solver: ConstantNoteQuestionSolver(answer: Note.E),
        );
        final question = service.nextQuestion();

        creationStrategy.question = Question(string: Note.E, fret: 1);
        final question2 = service.nextQuestion();

        expect(question, Question(string: Note.E, fret: 0));
        expect(question2, Question(string: Note.E, fret: 1));
      });
    });
  });
}

class ConstantQuestionCreationStrategy implements QuestionCreationStrategy {
  Question question;
  ConstantQuestionCreationStrategy({required this.question});

  @override
  Question createNextQuestion() => question;
}

class ConstantNoteQuestionSolver implements QuestionSolver {
  final Note _answer;
  ConstantNoteQuestionSolver({required answer}) : _answer = answer;

  @override
  Note answer({required Question of}) => _answer;
}
