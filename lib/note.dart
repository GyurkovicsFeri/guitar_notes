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

extension NoteManipulation on Note {
  Note decrement({required int by}) {
    return Note.values[(Note.values.indexOf(this) - by) % Note.values.length];
  }
}

extension Distinct on List<Note> {
  List<Note> get distinct => toSet().toList();
}
