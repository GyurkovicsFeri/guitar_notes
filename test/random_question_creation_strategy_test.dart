import 'package:flutter_test/flutter_test.dart';
import 'package:guitar_notes/guitar_notes_service.dart';

void main() {
  group("RandomQuestionCreationStrategy", () {
    group('createNextQuestion', () {
      test('should calculate a new question for every call', () {
        final strategy = RandomQuestionCreationStrategy();
        final question = strategy.createNextQuestion();
        expect(question, isNotNull);

        final question2 = strategy.createNextQuestion();
        expect(question2, isNotNull);
        
        expect(question, isNot(equals(question2)));
      });
    });
  });
}
