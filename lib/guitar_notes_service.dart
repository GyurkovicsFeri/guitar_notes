import 'dart:math';

import 'package:flutter/foundation.dart';

class GuitarNotesService extends ChangeNotifier {
  Question _currentQuestion = Question.forStringAndFret(string: Note.E, fret: 0);

  Question get currentQuestion => _currentQuestion;
  set currentQuestion(Question value) {
    _currentQuestion = value;
    notifyListeners();
  }

  Question nextQuestion() {
    final random = Random();
    final guitarString = guitarStrings[random.nextInt(5)];

    final fret = random.nextInt(12);
    final question = Question.forStringAndFret(string: guitarString, fret: fret);
    currentQuestion = question;
    return question;
  }

  bool isCorrect(Note answer) {
    return currentQuestion.answer == answer;
  }
}

class Question {
  final String hint;
  final Note answer;

  Question({
    required this.hint,
    required this.answer,
  });

  factory Question.forStringAndFret({
    required Note string,
    required int fret,
  }) {
    final answer = Note.values[(Note.values.indexOf(string) + fret) % Note.values.length];
    final question = Question(
      hint: '${string.localizedName}$fret',
      answer: answer,
    );

    return question;
  }
}

const guitarStrings = [Note.E, Note.B, Note.G, Note.D, Note.A];

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
