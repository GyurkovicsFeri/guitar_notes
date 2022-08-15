import 'dart:math';

import 'note.dart';
import 'question.dart';

abstract class QuestionCreationStrategy {
  Question createNextQuestion();
}

class RandomQuestionCreationStrategy implements QuestionCreationStrategy {
  Question? _lastQuestion;
  List<Note> _strings;

  RandomQuestionCreationStrategy({
    required List<Note> strings,
  }) : _strings = strings.distinct;

  void changeStrings(List<Note> strings) {
    _strings = strings.distinct;
  }

  @override
  Question createNextQuestion() {
    final random = Random();
    final guitarString = _strings[random.nextInt(_strings.length)];

    final fret = random.nextInt(12);
    final question = Question(string: guitarString, fret: fret);

    if (_lastQuestion == question) {
      return createNextQuestion();
    }

    _lastQuestion = question;
    return question;
  }
}
