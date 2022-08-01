import 'package:flutter_test/flutter_test.dart';
import 'package:guitar_notes/guitar_notes_service.dart';

void main() {
  group("Guitar Notes Service", () {
    group('nextQuestion', () {
      test('should generate a new question', () {
        final service = GuitarNotesService();
        final question = service.nextQuestion();
        expect(question, isNotNull);
        expect(question, isA<Question>());
        expect(service.currentQuestion, equals(question));
      });

      test('should notify listeners', () {
        var isCalled = false;
        final service = GuitarNotesService();
        Question? questionFromListener;
        service.addListener(() {
          questionFromListener = service.currentQuestion;
          isCalled = true;
        });
        final questionFromReturn = service.nextQuestion();
        expect(isCalled, equals(true));
        expect(questionFromListener, equals(questionFromReturn));
      });

      test('should return a question with a hint', () {
        final service = GuitarNotesService();
        final question = service.nextQuestion();
        expect(question.hint, isNotNull);
      });

      test('should return a question with a correct answer', () {
        final service = GuitarNotesService();
        final question = service.nextQuestion();
        expect(question.answer, isNotNull);
      });

      test('should create a new question every time', () async {
        final service = GuitarNotesService();

        final question = service.nextQuestion();
        final question2 = service.nextQuestion();

        expect(question, isNot(question2));
      });
    });
  });
}
