import 'dart:collection';
import 'dart:math';

import 'package:flutter/foundation.dart';

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

class QuestionSolver {
  Note answer({required Question of}) {
    return Note.values[(Note.values.indexOf(of.string) + of.fret) % Note.values.length];
  }
}

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

class Question {
  final String hint;
  final Note string;
  final int fret;

  Question({
    required this.string,
    required this.fret,
  }) : hint = '${string.localizedName}$fret';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Question && runtimeType == other.runtimeType && string == other.string && fret == other.fret;

  @override
  int get hashCode => string.hashCode ^ fret.hashCode;
}

enum Note { C, cSharp, D, dSharp, E, F, fSharp, G, gSharp, A, aSharp, B }

extension NoteLocalizedName on Note {
  String get localizedName {
    switch (this) {
      case Note.A:
        return 'A';
      case Note.aSharp:
        return 'A#';
      case Note.B:
        return 'B';
      case Note.C:
        return 'C';
      case Note.cSharp:
        return 'C#';
      case Note.D:
        return 'D';
      case Note.dSharp:
        return 'D#';
      case Note.E:
        return 'E';
      case Note.F:
        return 'F';
      case Note.fSharp:
        return 'F#';
      case Note.G:
        return 'G';
      case Note.gSharp:
        return 'G#';
    }
  }
}

extension Distinct on List<Note> {
  List<Note> get distinct => toSet().toList();
}

class TuningService extends ChangeNotifier {
  List<Note> _strings;

  TuningService({required List<Note> strings}) : _strings = strings;

  List<Note> get strings => UnmodifiableListView(_strings);
  set strings(List<Note> value) {
    _strings = value;
    notifyListeners();
  }

  static List<Note> getStandardTuning() {
    return [
      Note.E,
      Note.A,
      Note.D,
      Note.G,
      Note.B,
      Note.E,
    ];
  }

  static List<Note> stepDown(List<Note> tuning, int steps) {
    final List<Note> result = [];
    for (int i = 0; i < tuning.length; i++) {
      final originalNote = tuning[i];
      final newNote = originalNote.stepDown(steps);
      result.add(newNote);
    }
    return result;
  }

  static List<Note> drop(List<Note> tuning) {
    final List<Note> result = List.from(tuning);
    result[0] = result[0].stepDown(2);
    return result;
  }
}

extension Manipulation on List<Note> {
  List<Note> stepDown(int steps) {
    return TuningService.stepDown(this, steps);
  }

  List<Note> drop() {
    return TuningService.drop(this);
  }
}

extension NoteManipulation on Note {
  Note stepDown(int steps) {
    return Note.values[(Note.values.indexOf(this) - steps) % Note.values.length];
  }
}
