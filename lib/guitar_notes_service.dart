import 'package:flutter/foundation.dart';
import 'package:guitar_notes/question.dart';
import 'package:guitar_notes/question_solver.dart';
import 'package:guitar_notes/tuning_service.dart';

import 'note.dart';
import 'question_creation_strategy.dart';

class GuitarNotesService extends ChangeNotifier {
  final QuestionCreationStrategy creation;
  final QuestionSolver solver;

  GuitarNotesService({
    required this.creation,
    required this.solver,
  }) {
    _currentQuestion = creation.createNextQuestion();
  }

  Question _currentQuestion = Question(string: Note.E, fret: 0);

  Question get currentQuestion => _currentQuestion;
  set currentQuestion(Question value) {
    _currentQuestion = value;
    notifyListeners();
  }

  Question nextQuestion() {
    currentQuestion = creation.createNextQuestion();
    return currentQuestion;
  }

  bool isCorrect(Note answer) {
    final goodAnswer = solver.answer(of: currentQuestion);
    return goodAnswer == answer;
  }
}

extension Distinct on List<Note> {
  List<Note> get distinct => toSet().toList();
}

